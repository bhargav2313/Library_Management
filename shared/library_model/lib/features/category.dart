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
    required: true,
    minLength: 1,
    maxLength: 150,
  );

  static final description = Property.text(
    'description',
    title: 'Description',
    lines: 3,
  );
}

final categoryEntity = Entity(
  name: 'category',
  title: 'Category',
  nature: EntityNature.category,
  db: const EntityDb(tableName: 'category_master'),
  uniqueKeys: [
    UniqueKey([CategoryProperties.code]),
  ],
  facets: [
    IdentityFacet(
      properties: [CategoryProperties.code, CategoryProperties.name],
    ),
    Facet(name: 'details', properties: [CategoryProperties.description]),
  ],
);

final categoryModule = Module(
  name: 'category',
  title: 'Category',
  entities: [categoryEntity],
  exports: const [EntityExport(entity: CategoryRefs.category)],
);
