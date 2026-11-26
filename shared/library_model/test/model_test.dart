import 'package:library_model/library_model.dart';
import 'package:test/test.dart';
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

void main() {
  test('the validator finds no errors', () {
    final errors = BlueprintValidator.validate(libraryBlueprint);
    expect(errors, isEmpty, reason: errors.map((e) => e.message).join('\n'));
  });

  test('modules map to schemas, entities to tables', () {
    expect(categoryModule.schema, 'category');
    expect(booksModule.schema, 'books');
    expect(membersModule.schema, 'members');
    expect(categoryEntity.db.tableName, 'category_master');
    expect(bookEntity.db.tableName, 'book_master');
    expect(memberEntity.db.tableName, 'member_master');
  });

  test('all fields live in the identity facet (one table per entity)', () {
    List<String> fields(Entity e) => [
      for (final f in e.facets) ...f.properties.map((p) => p.name),
    ];
    expect([for (final f in categoryEntity.facets) f.name], ['identity']);
    expect([for (final f in bookEntity.facets) f.name], ['identity']);
    expect([for (final f in memberEntity.facets) f.name], ['identity']);
    expect(fields(categoryEntity), [
      'category_code',
      'category_name',
      'description',
    ]);
    expect(fields(bookEntity), [
      'book_code',
      'book_name',
      'category_id',
      'author',
    ]);
    expect(fields(memberEntity), [
      'member_code',
      'member_name',
      'email',
      'phone',
      'membership_type',
      'joined_on',
      'validate_till',
      'is_active',
    ]);
  });

  test('books depends on category; category exports its entity', () {
    expect(booksModule.dependencies, [CategoryRefs.module]);
    expect(categoryModule.exports.map((e) => e.qualifiedName), [
      'category.category',
    ]);
  });

  test('codes are auto-numbered with CAT, BK, and MEM prefixes', () {
    String? prefix(Property<Object?> p) =>
        p.facets.whereType<NumberPrefixFacet>().firstOrNull?.prefix;
    expect(prefix(CategoryProperties.code), 'CAT');
    expect(prefix(BookProperties.code), 'BK');
    expect(prefix(MemberProperties.code), 'MEM');
  });

  test('member choice, date, yesNo, lengths, and display are configured', () {
    final choice = MemberProperties.membershipType.kind as ChoiceKind<String>;
    expect(choice.layout, ChoiceLayout.dropdown);
    expect(choice.options.map((o) => o.title), ['Student', 'Staff', 'Public']);
    expect((MemberProperties.name.kind as TextKind).maxLength, 100);
    expect(MemberProperties.email.required, isTrue);
    expect((MemberProperties.email.kind as TextKind).maxLength, 50);
    expect((MemberProperties.phone.kind as TextKind).maxLength, 10);
    expect(MemberProperties.joinedOn.kind, isA<DateKind>());
    expect(MemberProperties.joinedOn.format, Format.date('dd-MM-yyyy'));
    expect(MemberProperties.joinedOn.checks, [
      const WithinDaysOfToday(future: 0),
    ]);
    expect(MemberProperties.validateTill.kind, isA<DateKind>());
    expect(MemberProperties.validateTill.required, isTrue);
    expect(MemberProperties.validateTill.format, Format.date('dd-MM-yyyy'));
    expect(MemberProperties.isActive.kind, isA<YesNoKind>());
    expect(memberEntity.ui.display.title, 'member_name');
  });

  test(
    'member joined_on allows today and past dates, rejects future dates',
    () {
      final schema = PropertySchema([MemberProperties.joinedOn]);
      const region = Region(locale: 'en-US', timeZone: TimeZone('UTC'));
      final today = DateTime.utc(2026, 11, 26);

      final past = CheckedValues.of(
        schema,
        JsonTarget({'joined_on': '2026-11-25'}),
        clock: () => today,
        region: region,
      );
      expect(past.issues, isEmpty);

      final sameDay = CheckedValues.of(
        schema,
        JsonTarget({'joined_on': '2026-11-26'}),
        clock: () => today,
        region: region,
      );
      expect(sameDay.issues, isEmpty);

      final future = CheckedValues.of(
        schema,
        JsonTarget({'joined_on': '2026-11-27'}),
        clock: () => today,
        region: region,
      );
      expect(future.issues, isNotEmpty);
    },
  );
}
