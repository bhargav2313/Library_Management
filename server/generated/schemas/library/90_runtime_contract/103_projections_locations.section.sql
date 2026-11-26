-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'list', 'list', 'flat', '[{"facet":"system","projection":"list","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"list","fields":[{"facet":"identity","statePath":"identity.section_code","flatName":"section_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_code"}},{"facet":"identity","statePath":"identity.section_name","flatName":"section_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_name"}},{"facet":"identity","statePath":"identity.floor_no","flatName":"floor_no","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.floor_no"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'summary', 'summary', 'flat', '[{"facet":"system","projection":"summary","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"summary","fields":[{"facet":"identity","statePath":"identity.section_code","flatName":"section_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_code"}},{"facet":"identity","statePath":"identity.section_name","flatName":"section_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_name"}},{"facet":"identity","statePath":"identity.floor_no","flatName":"floor_no","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.floor_no"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'detail', 'detail', 'nested', '[{"facet":"system","projection":"detail","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}},{"facet":"system","statePath":"system.created_at","flatName":"created_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.created_at"}},{"facet":"system","statePath":"system.updated_at","flatName":"updated_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.updated_at"}},{"facet":"system","statePath":"system.archived_at","flatName":"archived_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.archived_at"}},{"facet":"system","statePath":"system.created_by","flatName":"created_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.created_by"}},{"facet":"system","statePath":"system.updated_by","flatName":"updated_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.updated_by"}}]},{"facet":"identity","projection":"detail","fields":[{"facet":"identity","statePath":"identity.section_code","flatName":"section_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_code"}},{"facet":"identity","statePath":"identity.section_name","flatName":"section_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_name"}},{"facet":"identity","statePath":"identity.floor_no","flatName":"floor_no","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.floor_no"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'reference', 'reference', 'flat', '[{"facet":"system","projection":"reference","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"reference","fields":[{"facet":"identity","statePath":"identity.section_code","flatName":"section_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_code"}},{"facet":"identity","statePath":"identity.section_name","flatName":"section_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_name"}},{"facet":"identity","statePath":"identity.floor_no","flatName":"floor_no","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.floor_no"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'picker', 'picker', 'flat', '[{"facet":"system","projection":"picker","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"picker","fields":[{"facet":"identity","statePath":"identity.section_code","flatName":"section_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_code"}},{"facet":"identity","statePath":"identity.section_name","flatName":"section_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_name"}},{"facet":"identity","statePath":"identity.floor_no","flatName":"floor_no","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.floor_no"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'list', 'SectionListProjection', 'lib/generated/projections/section_list.dart', '// Generated projection DTO for locations.section:list.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class SectionListProjection {
  const SectionListProjection({
    required this.id,
    required this.sectionCode,
    required this.sectionName,
    required this.floorNo,
  });

  final String id;
  final String sectionCode;
  final String sectionName;
  final int floorNo;

  factory SectionListProjection.fromJson(Map<String, Object?> json) {
    return SectionListProjection(
      id: json[''id''] as String,
      sectionCode: json[''section_code''] as String,
      sectionName: json[''section_name''] as String,
      floorNo: json[''floor_no''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''section_code'': sectionCode,
    ''section_name'': sectionName,
    ''floor_no'': floorNo,
  };
}
', '{"qualified_projection":"locations.section:list","shape":"flat","kind":"list"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'summary', 'SectionSummaryProjection', 'lib/generated/projections/section_summary.dart', '// Generated projection DTO for locations.section:summary.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class SectionSummaryProjection {
  const SectionSummaryProjection({
    required this.id,
    required this.sectionCode,
    required this.sectionName,
    required this.floorNo,
  });

  final String id;
  final String sectionCode;
  final String sectionName;
  final int floorNo;

  factory SectionSummaryProjection.fromJson(Map<String, Object?> json) {
    return SectionSummaryProjection(
      id: json[''id''] as String,
      sectionCode: json[''section_code''] as String,
      sectionName: json[''section_name''] as String,
      floorNo: json[''floor_no''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''section_code'': sectionCode,
    ''section_name'': sectionName,
    ''floor_no'': floorNo,
  };
}
', '{"qualified_projection":"locations.section:summary","shape":"flat","kind":"summary"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'detail', 'SectionDetailProjection', 'lib/generated/projections/section_detail.dart', '// Generated projection DTO for locations.section:detail.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class SectionDetailProjection {
  const SectionDetailProjection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.sectionCode,
    required this.sectionName,
    required this.floorNo,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime archivedAt;
  final String createdBy;
  final String updatedBy;
  final String sectionCode;
  final String sectionName;
  final int floorNo;

  factory SectionDetailProjection.fromJson(Map<String, Object?> json) {
    return SectionDetailProjection(
      id: json[''id''] as String,
      createdAt: DateTime.parse(json[''created_at''] as String),
      updatedAt: DateTime.parse(json[''updated_at''] as String),
      archivedAt: DateTime.parse(json[''archived_at''] as String),
      createdBy: json[''created_by''] as String,
      updatedBy: json[''updated_by''] as String,
      sectionCode: json[''section_code''] as String,
      sectionName: json[''section_name''] as String,
      floorNo: json[''floor_no''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''created_at'': createdAt.toIso8601String(),
    ''updated_at'': updatedAt.toIso8601String(),
    ''archived_at'': archivedAt.toIso8601String(),
    ''created_by'': createdBy,
    ''updated_by'': updatedBy,
    ''section_code'': sectionCode,
    ''section_name'': sectionName,
    ''floor_no'': floorNo,
  };
}
', '{"qualified_projection":"locations.section:detail","shape":"nested","kind":"detail"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'reference', 'SectionReferenceProjection', 'lib/generated/projections/section_reference.dart', '// Generated projection DTO for locations.section:reference.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class SectionReferenceProjection {
  const SectionReferenceProjection({
    required this.id,
    required this.sectionCode,
    required this.sectionName,
    required this.floorNo,
  });

  final String id;
  final String sectionCode;
  final String sectionName;
  final int floorNo;

  factory SectionReferenceProjection.fromJson(Map<String, Object?> json) {
    return SectionReferenceProjection(
      id: json[''id''] as String,
      sectionCode: json[''section_code''] as String,
      sectionName: json[''section_name''] as String,
      floorNo: json[''floor_no''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''section_code'': sectionCode,
    ''section_name'': sectionName,
    ''floor_no'': floorNo,
  };
}
', '{"qualified_projection":"locations.section:reference","shape":"flat","kind":"reference"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#05c37e318b77651b', 'locations', 'section', 'picker', 'SectionPickerProjection', 'lib/generated/projections/section_picker.dart', '// Generated projection DTO for locations.section:picker.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class SectionPickerProjection {
  const SectionPickerProjection({
    required this.id,
    required this.sectionCode,
    required this.sectionName,
    required this.floorNo,
  });

  final String id;
  final String sectionCode;
  final String sectionName;
  final int floorNo;

  factory SectionPickerProjection.fromJson(Map<String, Object?> json) {
    return SectionPickerProjection(
      id: json[''id''] as String,
      sectionCode: json[''section_code''] as String,
      sectionName: json[''section_name''] as String,
      floorNo: json[''floor_no''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''section_code'': sectionCode,
    ''section_name'': sectionName,
    ''floor_no'': floorNo,
  };
}
', '{"qualified_projection":"locations.section:picker","shape":"flat","kind":"picker"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;
