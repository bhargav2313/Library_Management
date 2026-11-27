-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'list', 'list', 'flat', '[{"facet":"system","projection":"list","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"list","fields":[{"facet":"identity","statePath":"identity.rack_code","flatName":"rack_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_code"}},{"facet":"identity","statePath":"identity.rack_name","flatName":"rack_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_name"}},{"facet":"identity","statePath":"identity.section_id","flatName":"section_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_id"}},{"facet":"identity","statePath":"identity.capacity","flatName":"capacity","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.capacity"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'summary', 'summary', 'flat', '[{"facet":"system","projection":"summary","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"summary","fields":[{"facet":"identity","statePath":"identity.rack_code","flatName":"rack_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_code"}},{"facet":"identity","statePath":"identity.rack_name","flatName":"rack_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_name"}},{"facet":"identity","statePath":"identity.section_id","flatName":"section_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_id"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'detail', 'detail', 'nested', '[{"facet":"system","projection":"detail","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}},{"facet":"system","statePath":"system.created_at","flatName":"created_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.created_at"}},{"facet":"system","statePath":"system.updated_at","flatName":"updated_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.updated_at"}},{"facet":"system","statePath":"system.archived_at","flatName":"archived_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.archived_at"}},{"facet":"system","statePath":"system.created_by","flatName":"created_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.created_by"}},{"facet":"system","statePath":"system.updated_by","flatName":"updated_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.updated_by"}}]},{"facet":"identity","projection":"detail","fields":[{"facet":"identity","statePath":"identity.rack_code","flatName":"rack_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_code"}},{"facet":"identity","statePath":"identity.rack_name","flatName":"rack_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_name"}},{"facet":"identity","statePath":"identity.section_id","flatName":"section_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_id"}},{"facet":"identity","statePath":"identity.capacity","flatName":"capacity","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.capacity"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'reference', 'reference', 'flat', '[{"facet":"system","projection":"reference","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"reference","fields":[{"facet":"identity","statePath":"identity.rack_code","flatName":"rack_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_code"}},{"facet":"identity","statePath":"identity.rack_name","flatName":"rack_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_name"}},{"facet":"identity","statePath":"identity.section_id","flatName":"section_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_id"}},{"facet":"identity","statePath":"identity.capacity","flatName":"capacity","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.capacity"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'picker', 'picker', 'flat', '[{"facet":"system","projection":"picker","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"picker","fields":[{"facet":"identity","statePath":"identity.rack_code","flatName":"rack_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_code"}},{"facet":"identity","statePath":"identity.rack_name","flatName":"rack_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.rack_name"}},{"facet":"identity","statePath":"identity.section_id","flatName":"section_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.section_id"}},{"facet":"identity","statePath":"identity.capacity","flatName":"capacity","type":"integer","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.capacity"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'list', 'RackListProjection', 'lib/generated/projections/rack_list.dart', '// Generated projection DTO for locations.rack:list.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class RackListProjection {
  const RackListProjection({
    required this.id,
    required this.rackCode,
    required this.rackName,
    required this.sectionId,
    required this.capacity,
  });

  final String id;
  final String rackCode;
  final String rackName;
  final String sectionId;
  final int capacity;

  factory RackListProjection.fromJson(Map<String, Object?> json) {
    return RackListProjection(
      id: json[''id''] as String,
      rackCode: json[''rack_code''] as String,
      rackName: json[''rack_name''] as String,
      sectionId: json[''section_id''] as String,
      capacity: json[''capacity''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''rack_code'': rackCode,
    ''rack_name'': rackName,
    ''section_id'': sectionId,
    ''capacity'': capacity,
  };
}
', '{"qualified_projection":"locations.rack:list","shape":"flat","kind":"list"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'summary', 'RackSummaryProjection', 'lib/generated/projections/rack_summary.dart', '// Generated projection DTO for locations.rack:summary.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class RackSummaryProjection {
  const RackSummaryProjection({
    required this.id,
    required this.rackCode,
    required this.rackName,
    required this.sectionId,
  });

  final String id;
  final String rackCode;
  final String rackName;
  final String sectionId;

  factory RackSummaryProjection.fromJson(Map<String, Object?> json) {
    return RackSummaryProjection(
      id: json[''id''] as String,
      rackCode: json[''rack_code''] as String,
      rackName: json[''rack_name''] as String,
      sectionId: json[''section_id''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''rack_code'': rackCode,
    ''rack_name'': rackName,
    ''section_id'': sectionId,
  };
}
', '{"qualified_projection":"locations.rack:summary","shape":"flat","kind":"summary"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'detail', 'RackDetailProjection', 'lib/generated/projections/rack_detail.dart', '// Generated projection DTO for locations.rack:detail.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class RackDetailProjection {
  const RackDetailProjection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.rackCode,
    required this.rackName,
    required this.sectionId,
    required this.capacity,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime archivedAt;
  final String createdBy;
  final String updatedBy;
  final String rackCode;
  final String rackName;
  final String sectionId;
  final int capacity;

  factory RackDetailProjection.fromJson(Map<String, Object?> json) {
    return RackDetailProjection(
      id: json[''id''] as String,
      createdAt: DateTime.parse(json[''created_at''] as String),
      updatedAt: DateTime.parse(json[''updated_at''] as String),
      archivedAt: DateTime.parse(json[''archived_at''] as String),
      createdBy: json[''created_by''] as String,
      updatedBy: json[''updated_by''] as String,
      rackCode: json[''rack_code''] as String,
      rackName: json[''rack_name''] as String,
      sectionId: json[''section_id''] as String,
      capacity: json[''capacity''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''created_at'': createdAt.toIso8601String(),
    ''updated_at'': updatedAt.toIso8601String(),
    ''archived_at'': archivedAt.toIso8601String(),
    ''created_by'': createdBy,
    ''updated_by'': updatedBy,
    ''rack_code'': rackCode,
    ''rack_name'': rackName,
    ''section_id'': sectionId,
    ''capacity'': capacity,
  };
}
', '{"qualified_projection":"locations.rack:detail","shape":"nested","kind":"detail"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'reference', 'RackReferenceProjection', 'lib/generated/projections/rack_reference.dart', '// Generated projection DTO for locations.rack:reference.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class RackReferenceProjection {
  const RackReferenceProjection({
    required this.id,
    required this.rackCode,
    required this.rackName,
    required this.sectionId,
    required this.capacity,
  });

  final String id;
  final String rackCode;
  final String rackName;
  final String sectionId;
  final int capacity;

  factory RackReferenceProjection.fromJson(Map<String, Object?> json) {
    return RackReferenceProjection(
      id: json[''id''] as String,
      rackCode: json[''rack_code''] as String,
      rackName: json[''rack_name''] as String,
      sectionId: json[''section_id''] as String,
      capacity: json[''capacity''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''rack_code'': rackCode,
    ''rack_name'': rackName,
    ''section_id'': sectionId,
    ''capacity'': capacity,
  };
}
', '{"qualified_projection":"locations.rack:reference","shape":"flat","kind":"reference"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#b33afb0cb5184a5b', 'locations', 'rack', 'picker', 'RackPickerProjection', 'lib/generated/projections/rack_picker.dart', '// Generated projection DTO for locations.rack:picker.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class RackPickerProjection {
  const RackPickerProjection({
    required this.id,
    required this.rackCode,
    required this.rackName,
    required this.sectionId,
    required this.capacity,
  });

  final String id;
  final String rackCode;
  final String rackName;
  final String sectionId;
  final int capacity;

  factory RackPickerProjection.fromJson(Map<String, Object?> json) {
    return RackPickerProjection(
      id: json[''id''] as String,
      rackCode: json[''rack_code''] as String,
      rackName: json[''rack_name''] as String,
      sectionId: json[''section_id''] as String,
      capacity: json[''capacity''] as int,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''rack_code'': rackCode,
    ''rack_name'': rackName,
    ''section_id'': sectionId,
    ''capacity'': capacity,
  };
}
', '{"qualified_projection":"locations.rack:picker","shape":"flat","kind":"picker"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;
