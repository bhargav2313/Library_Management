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

  test('facets group the fields', () {
    List<String> facets(Entity e) => [for (final f in e.facets) f.name];
    expect(facets(categoryEntity), ['identity', 'details']);
    expect(facets(bookEntity), ['identity', 'relationship', 'details']);
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
