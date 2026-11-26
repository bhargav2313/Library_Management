-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'list', 'list', 'flat', '[{"facet":"system","projection":"list","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"list","fields":[{"facet":"identity","statePath":"identity.category_code","flatName":"category_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_code"}},{"facet":"identity","statePath":"identity.category_name","flatName":"category_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_name"}},{"facet":"identity","statePath":"identity.description","flatName":"description","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":false,"hidden":false,"metadata":{"source_path":"identity.properties.description"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'summary', 'summary', 'flat', '[{"facet":"system","projection":"summary","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"summary","fields":[{"facet":"identity","statePath":"identity.category_code","flatName":"category_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_code"}},{"facet":"identity","statePath":"identity.category_name","flatName":"category_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_name"}},{"facet":"identity","statePath":"identity.description","flatName":"description","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":false,"hidden":false,"metadata":{"source_path":"identity.properties.description"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'detail', 'detail', 'nested', '[{"facet":"system","projection":"detail","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}},{"facet":"system","statePath":"system.created_at","flatName":"created_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.created_at"}},{"facet":"system","statePath":"system.updated_at","flatName":"updated_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.updated_at"}},{"facet":"system","statePath":"system.archived_at","flatName":"archived_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.archived_at"}},{"facet":"system","statePath":"system.created_by","flatName":"created_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.created_by"}},{"facet":"system","statePath":"system.updated_by","flatName":"updated_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.updated_by"}}]},{"facet":"identity","projection":"detail","fields":[{"facet":"identity","statePath":"identity.category_code","flatName":"category_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_code"}},{"facet":"identity","statePath":"identity.category_name","flatName":"category_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_name"}},{"facet":"identity","statePath":"identity.description","flatName":"description","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":false,"hidden":false,"metadata":{"source_path":"identity.properties.description"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'reference', 'reference', 'flat', '[{"facet":"system","projection":"reference","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"reference","fields":[{"facet":"identity","statePath":"identity.description","flatName":"description","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":false,"hidden":false,"metadata":{"source_path":"identity.properties.description"}},{"facet":"identity","statePath":"identity.category_code","flatName":"category_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_code"}},{"facet":"identity","statePath":"identity.category_name","flatName":"category_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_name"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'picker', 'picker', 'flat', '[{"facet":"system","projection":"picker","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"picker","fields":[{"facet":"identity","statePath":"identity.category_code","flatName":"category_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_code"}},{"facet":"identity","statePath":"identity.category_name","flatName":"category_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_name"}},{"facet":"identity","statePath":"identity.description","flatName":"description","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":false,"hidden":false,"metadata":{"source_path":"identity.properties.description"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'list', 'CategoryListProjection', 'lib/generated/projections/category_list.dart', '// Generated projection DTO for category.category:list.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class CategoryListProjection {
  const CategoryListProjection({
    required this.id,
    required this.categoryCode,
    required this.categoryName,
    required this.description,
  });

  final String id;
  final String categoryCode;
  final String categoryName;
  final String description;

  factory CategoryListProjection.fromJson(Map<String, Object?> json) {
    return CategoryListProjection(
      id: json[''id''] as String,
      categoryCode: json[''category_code''] as String,
      categoryName: json[''category_name''] as String,
      description: json[''description''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''category_code'': categoryCode,
    ''category_name'': categoryName,
    ''description'': description,
  };
}
', '{"qualified_projection":"category.category:list","shape":"flat","kind":"list"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'summary', 'CategorySummaryProjection', 'lib/generated/projections/category_summary.dart', '// Generated projection DTO for category.category:summary.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class CategorySummaryProjection {
  const CategorySummaryProjection({
    required this.id,
    required this.categoryCode,
    required this.categoryName,
    required this.description,
  });

  final String id;
  final String categoryCode;
  final String categoryName;
  final String description;

  factory CategorySummaryProjection.fromJson(Map<String, Object?> json) {
    return CategorySummaryProjection(
      id: json[''id''] as String,
      categoryCode: json[''category_code''] as String,
      categoryName: json[''category_name''] as String,
      description: json[''description''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''category_code'': categoryCode,
    ''category_name'': categoryName,
    ''description'': description,
  };
}
', '{"qualified_projection":"category.category:summary","shape":"flat","kind":"summary"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'detail', 'CategoryDetailProjection', 'lib/generated/projections/category_detail.dart', '// Generated projection DTO for category.category:detail.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class CategoryDetailProjection {
  const CategoryDetailProjection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.categoryCode,
    required this.categoryName,
    required this.description,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime archivedAt;
  final String createdBy;
  final String updatedBy;
  final String categoryCode;
  final String categoryName;
  final String description;

  factory CategoryDetailProjection.fromJson(Map<String, Object?> json) {
    return CategoryDetailProjection(
      id: json[''id''] as String,
      createdAt: DateTime.parse(json[''created_at''] as String),
      updatedAt: DateTime.parse(json[''updated_at''] as String),
      archivedAt: DateTime.parse(json[''archived_at''] as String),
      createdBy: json[''created_by''] as String,
      updatedBy: json[''updated_by''] as String,
      categoryCode: json[''category_code''] as String,
      categoryName: json[''category_name''] as String,
      description: json[''description''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''created_at'': createdAt.toIso8601String(),
    ''updated_at'': updatedAt.toIso8601String(),
    ''archived_at'': archivedAt.toIso8601String(),
    ''created_by'': createdBy,
    ''updated_by'': updatedBy,
    ''category_code'': categoryCode,
    ''category_name'': categoryName,
    ''description'': description,
  };
}
', '{"qualified_projection":"category.category:detail","shape":"nested","kind":"detail"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'reference', 'CategoryReferenceProjection', 'lib/generated/projections/category_reference.dart', '// Generated projection DTO for category.category:reference.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class CategoryReferenceProjection {
  const CategoryReferenceProjection({
    required this.id,
    required this.description,
    required this.categoryCode,
    required this.categoryName,
  });

  final String id;
  final String description;
  final String categoryCode;
  final String categoryName;

  factory CategoryReferenceProjection.fromJson(Map<String, Object?> json) {
    return CategoryReferenceProjection(
      id: json[''id''] as String,
      description: json[''description''] as String,
      categoryCode: json[''category_code''] as String,
      categoryName: json[''category_name''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''description'': description,
    ''category_code'': categoryCode,
    ''category_name'': categoryName,
  };
}
', '{"qualified_projection":"category.category:reference","shape":"flat","kind":"reference"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'category', 'category', 'picker', 'CategoryPickerProjection', 'lib/generated/projections/category_picker.dart', '// Generated projection DTO for category.category:picker.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class CategoryPickerProjection {
  const CategoryPickerProjection({
    required this.id,
    required this.categoryCode,
    required this.categoryName,
    required this.description,
  });

  final String id;
  final String categoryCode;
  final String categoryName;
  final String description;

  factory CategoryPickerProjection.fromJson(Map<String, Object?> json) {
    return CategoryPickerProjection(
      id: json[''id''] as String,
      categoryCode: json[''category_code''] as String,
      categoryName: json[''category_name''] as String,
      description: json[''description''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''category_code'': categoryCode,
    ''category_name'': categoryName,
    ''description'': description,
  };
}
', '{"qualified_projection":"category.category:picker","shape":"flat","kind":"picker"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;
