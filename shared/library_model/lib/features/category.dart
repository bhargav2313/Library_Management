// Module "category": owns the Category entity.
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

abstract final class CategoryRefs {
  static const module = ModuleRef('category');
  static const category = EntityRef(module: module, name: 'category');
}

/// The fields of the Create Category form.
abstract final class CategoryProperties {
  /// Auto-generated: CAT-00001, CAT-00002 … (read-only in the form).
  static final code = StandardProperties.number(
    name: 'category_code',
    prefix: 'CAT',
    scheme: NumberScheme.prefixed(digits: 5),
    maxLength: 9,
  );

  static final name = Property.text(
    'category_name',
    title: 'Category Name',
    hint: 'e.g. Science Fiction',
    required: true,
    minLength: 2,
    maxLength: 150,
  );

  static final description = Property.text(
    'description',
    title: 'Description',
    hint: 'Brief overview of this category',
    lines: 3,
    maxLength: 500,
  );
}

final categoryEntity = Entity(
  name: 'category',
  title: 'Category',
  nature: EntityNature.category,
  db: const EntityDb(tableName: 'category_master'),
  ui: const EntityUI(display: RecordDisplay(title: 'category_name')),
  uniqueKeys: [
    UniqueKey([CategoryProperties.code]),
    UniqueKey([CategoryProperties.name]),
  ],
  facets: [
    // Every field sits in the identity facet, so all of them are columns of
    // category_master. (Each extra Facet would become its own table.)
    IdentityFacet(
      properties: [
        CategoryProperties.code,
        CategoryProperties.name,
        CategoryProperties.description,
      ],
    ),
  ],
);

final categoryModule = Module(
  name: 'category',
  title: 'Category',
  entities: [categoryEntity],
  exports: const [EntityExport(entity: CategoryRefs.category)],
);
