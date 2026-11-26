// Module "books": owns the Book entity. A Book belongs to one Category.
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

import 'category.dart';

abstract final class BookRefs {
  static const module = ModuleRef('books');
  static const book = EntityRef(module: module, name: 'book');
}

/// The fields of the Create Book form.
abstract final class BookProperties {
  /// Auto-generated: BK-00001, BK-00002 … (read-only in the form).
  static final code = StandardProperties.number(
    name: 'book_code',
    prefix: 'BK',
    scheme: NumberScheme.prefixed(digits: 5),
    maxLength: 8,
  );

  static final name = Property.text(
    'book_name',
    title: 'Book Name',
    required: true,
    minLength: 1,
    maxLength: 150,
  );

  /// Parent Category (dropdown in the form).
  static final categoryId = StandardProperties.reference(
    'category_id',
    title: 'Category',
    required: true,
    target: CategoryRefs.category,
  );

  static final category = Relationship(
    name: 'category',
    target: CategoryRefs.category,
    field: categoryId,
    cardinality: RelationshipCardinality.hasOne,
    kind: RelationshipMeaning.classifiedBy,
    onDelete: OnDelete.restrict,
  );

  static final author = Property.text(
    'author',
    title: 'Author',
    maxLength: 150,
  );
}

final bookEntity = Entity(
  name: 'book',
  title: 'Book',
  nature: EntityNature.information,
  db: const EntityDb(tableName: 'book_master'),
  uniqueKeys: [
    UniqueKey([BookProperties.code]),
  ],
  facets: [
    // One facet = one table: book_master holds every field, including the
    // category_id foreign key. (Each extra Facet would become its own table.)
    IdentityFacet(
      properties: [
        BookProperties.code,
        BookProperties.name,
        BookProperties.categoryId,
        BookProperties.author,
      ],
      relationships: [BookProperties.category],
    ),
  ],
);

final booksModule = Module(
  name: 'books',
  title: 'Books',
  entities: [bookEntity],
  dependencies: const [CategoryRefs.module],
  exports: const [EntityExport(entity: BookRefs.book)],
);
