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
    expect(categoryEntity.db.tableName, 'category_master');
    expect(bookEntity.db.tableName, 'book_master');
  });

  test('all fields live in the identity facet (one table per entity)', () {
    List<String> fields(Entity e) => [
      for (final f in e.facets) ...f.properties.map((p) => p.name),
    ];
    expect([for (final f in categoryEntity.facets) f.name], ['identity']);
    expect([for (final f in bookEntity.facets) f.name], ['identity']);
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
  });

  test('books depends on category; category exports its entity', () {
    expect(booksModule.dependencies, [CategoryRefs.module]);
    expect(
      categoryModule.exports.map((e) => e.qualifiedName),
      ['category.category'],
    );
  });

  test('codes are auto-numbered with CAT and BK prefixes', () {
    String? prefix(Property<Object?> p) =>
        p.facets.whereType<NumberPrefixFacet>().firstOrNull?.prefix;
    expect(prefix(CategoryProperties.code), 'CAT');
    expect(prefix(BookProperties.code), 'BK');
  });
}
