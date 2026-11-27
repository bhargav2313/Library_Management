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
    expect(locationsModule.schema, 'locations');
    expect(membersModule.schema, 'members');
    expect(categoryEntity.db.tableName, 'category_master');
    expect(bookEntity.db.tableName, 'book_master');
    expect(sectionEntity.db.tableName, 'section_master');
    expect(rackEntity.db.tableName, 'rack_master');
    expect(memberEntity.db.tableName, 'member_master');
  });

  test('all fields live in the identity facet (one table per entity)', () {
    List<String> fields(Entity e) => [
      for (final f in e.facets) ...f.properties.map((p) => p.name),
    ];
    expect([for (final f in categoryEntity.facets) f.name], ['identity']);
    expect([for (final f in bookEntity.facets) f.name], ['identity']);
    expect([for (final f in sectionEntity.facets) f.name], ['identity']);
    expect([for (final f in rackEntity.facets) f.name], ['identity']);
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
    expect(fields(sectionEntity), ['section_code', 'section_name', 'floor_no']);
    expect(fields(rackEntity), [
      'rack_code',
      'rack_name',
      'section_id',
      'capacity',
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

  test('books depends on category; category and locations export entities', () {
    expect(booksModule.dependencies, [CategoryRefs.module]);
    expect(categoryModule.exports.map((e) => e.qualifiedName), [
      'category.category',
    ]);
    expect(locationsModule.exports.map((e) => e.qualifiedName), [
      'locations.section',
      'locations.rack',
    ]);
  });

  test('codes are auto-numbered with CAT, BK, SEC, RK, and MEM prefixes', () {
    String? prefix(Property<Object?> p) =>
        p.facets.whereType<NumberPrefixFacet>().firstOrNull?.prefix;
    expect(prefix(CategoryProperties.code), 'CAT');
    expect(prefix(BookProperties.code), 'BK');
    expect(prefix(SectionProperties.code), 'SEC');
    expect(prefix(RackProperties.code), 'RK');
    expect(prefix(MemberProperties.code), 'MEM');
  });

  test('member choice, date, yesNo, lengths, and display are configured', () {
    final choice = MemberProperties.membershipType.kind as ChoiceKind<String>;
    expect(choice.layout, ChoiceLayout.dropdown);
    expect(choice.options.map((o) => o.title), ['Student', 'Staff', 'Public']);
    expect((MemberProperties.name.kind as TextKind).maxLength, 100);
    expect(MemberProperties.email.required, isTrue);
    expect((MemberProperties.email.kind as TextKind).maxLength, 100);
    expect(MemberProperties.phone.required, isTrue);
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
    expect(MemberProperties.isActive.defaultsTo, const DefaultValue(true));
    expect(memberEntity.ui.display.title, 'member_name');
  });

  test('unique keys and numeric bounds are configured across entities', () {
    expect(categoryEntity.uniqueKeys.length, 2);
    expect((CategoryProperties.description.kind as TextKind).maxLength, 500);
    expect(BookProperties.author.required, isTrue);
    expect(sectionEntity.uniqueKeys.length, 2);
    expect(rackEntity.uniqueKeys.length, 2);
    expect((RackProperties.capacity.kind as WholeNumberKind).max, 1000);
    expect(memberEntity.uniqueKeys.length, 3);
  });

  test('member validation rules enforce name, email, phone, and dates', () {
    final schema = PropertySchema([
      MemberProperties.name,
      MemberProperties.email,
      MemberProperties.phone,
      MemberProperties.joinedOn,
      MemberProperties.validateTill,
    ]);
    const region = Region(locale: 'en-US', timeZone: TimeZone('UTC'));
    final today = DateTime.utc(2026, 11, 27);

    CheckedValues check(Map<String, Object?> data) => CheckedValues.of(
      schema,
      JsonTarget(data),
      clock: () => today,
      region: region,
    );

    final valid = check({
      'member_name': 'Priya Sharma',
      'email': 'priya@library.org',
      'phone': '9876543210',
      'joined_on': '2026-11-26',
      'validate_till': '2027-11-26',
    });
    expect(valid.issues, isEmpty);

    // Same day validate_till == joined_on is allowed.
    final sameDay = check({
      'member_name': 'A. P. J. Kalam',
      'email': 'kalam@library.org',
      'phone': '9123456789',
      'joined_on': '2026-11-27',
      'validate_till': '2026-11-27',
    });
    expect(sameDay.issues, isEmpty);

    // Digits in member_name rejected.
    expect(
      check({
        'member_name': 'Priya123',
        'email': 'priya@library.org',
        'phone': '9876543210',
        'joined_on': '2026-11-26',
        'validate_till': '2027-11-26',
      }).issues,
      isNotEmpty,
    );

    // Invalid email rejected.
    expect(
      check({
        'member_name': 'Priya Sharma',
        'email': 'not-an-email',
        'phone': '9876543210',
        'joined_on': '2026-11-26',
        'validate_till': '2027-11-26',
      }).issues,
      isNotEmpty,
    );

    // Non-numeric or < 10 digit phone rejected.
    expect(
      check({
        'member_name': 'Priya Sharma',
        'email': 'priya@library.org',
        'phone': '98765abc10',
        'joined_on': '2026-11-26',
        'validate_till': '2027-11-26',
      }).issues,
      isNotEmpty,
    );
    expect(
      check({
        'member_name': 'Priya Sharma',
        'email': 'priya@library.org',
        'phone': '98765',
        'joined_on': '2026-11-26',
        'validate_till': '2027-11-26',
      }).issues,
      isNotEmpty,
    );

    // Future joined_on rejected.
    expect(
      check({
        'member_name': 'Priya Sharma',
        'email': 'priya@library.org',
        'phone': '9876543210',
        'joined_on': '2026-11-28',
        'validate_till': '2027-11-26',
      }).issues,
      isNotEmpty,
    );

    // validate_till before joined_on rejected.
    expect(
      check({
        'member_name': 'Priya Sharma',
        'email': 'priya@library.org',
        'phone': '9876543210',
        'joined_on': '2026-11-26',
        'validate_till': '2026-11-25',
      }).issues,
      isNotEmpty,
    );
  });

  test('shell text scaling exposes multiple steps for the user menu slider', () {
    expect(
      libraryBlueprint.shell.appearance.textScaleSteps,
      [0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5],
    );
  });
}
