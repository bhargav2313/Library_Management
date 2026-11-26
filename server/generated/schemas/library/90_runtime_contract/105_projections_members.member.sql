-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'list', 'list', 'flat', '[{"facet":"system","projection":"list","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"list","fields":[{"facet":"identity","statePath":"identity.member_code","flatName":"member_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_code"}},{"facet":"identity","statePath":"identity.member_name","flatName":"member_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_name"}},{"facet":"identity","statePath":"identity.email","flatName":"email","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.email"}},{"facet":"identity","statePath":"identity.phone","flatName":"phone","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.phone"}},{"facet":"identity","statePath":"identity.membership_type","flatName":"membership_type","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.membership_type"}},{"facet":"identity","statePath":"identity.joined_on","flatName":"joined_on","type":"date","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.joined_on"}},{"facet":"identity","statePath":"identity.validate_till","flatName":"validate_till","type":"date","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.validate_till"}},{"facet":"identity","statePath":"identity.is_active","flatName":"is_active","type":"boolean","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.is_active"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'summary', 'summary', 'flat', '[{"facet":"system","projection":"summary","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"summary","fields":[{"facet":"identity","statePath":"identity.email","flatName":"email","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.email"}},{"facet":"identity","statePath":"identity.member_code","flatName":"member_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_code"}},{"facet":"identity","statePath":"identity.member_name","flatName":"member_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_name"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'detail', 'detail', 'nested', '[{"facet":"system","projection":"detail","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}},{"facet":"system","statePath":"system.created_at","flatName":"created_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.created_at"}},{"facet":"system","statePath":"system.updated_at","flatName":"updated_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.updated_at"}},{"facet":"system","statePath":"system.archived_at","flatName":"archived_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.archived_at"}},{"facet":"system","statePath":"system.created_by","flatName":"created_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.created_by"}},{"facet":"system","statePath":"system.updated_by","flatName":"updated_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.updated_by"}}]},{"facet":"identity","projection":"detail","fields":[{"facet":"identity","statePath":"identity.member_code","flatName":"member_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_code"}},{"facet":"identity","statePath":"identity.member_name","flatName":"member_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_name"}},{"facet":"identity","statePath":"identity.email","flatName":"email","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.email"}},{"facet":"identity","statePath":"identity.phone","flatName":"phone","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.phone"}},{"facet":"identity","statePath":"identity.membership_type","flatName":"membership_type","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.membership_type"}},{"facet":"identity","statePath":"identity.joined_on","flatName":"joined_on","type":"date","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.joined_on"}},{"facet":"identity","statePath":"identity.validate_till","flatName":"validate_till","type":"date","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.validate_till"}},{"facet":"identity","statePath":"identity.is_active","flatName":"is_active","type":"boolean","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.is_active"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'reference', 'reference', 'flat', '[{"facet":"system","projection":"reference","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"reference","fields":[{"facet":"identity","statePath":"identity.email","flatName":"email","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.email"}},{"facet":"identity","statePath":"identity.member_code","flatName":"member_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_code"}},{"facet":"identity","statePath":"identity.member_name","flatName":"member_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_name"}},{"facet":"identity","statePath":"identity.phone","flatName":"phone","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.phone"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'picker', 'picker', 'flat', '[{"facet":"system","projection":"picker","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"picker","fields":[{"facet":"identity","statePath":"identity.email","flatName":"email","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.email"}},{"facet":"identity","statePath":"identity.member_name","flatName":"member_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.member_name"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'list', 'MemberListProjection', 'lib/generated/projections/member_list.dart', '// Generated projection DTO for members.member:list.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class MemberListProjection {
  const MemberListProjection({
    required this.id,
    required this.memberCode,
    required this.memberName,
    required this.email,
    required this.phone,
    required this.membershipType,
    required this.joinedOn,
    required this.validateTill,
    required this.isActive,
  });

  final String id;
  final String memberCode;
  final String memberName;
  final String email;
  final String phone;
  final String membershipType;
  final DateTime joinedOn;
  final DateTime validateTill;
  final bool isActive;

  factory MemberListProjection.fromJson(Map<String, Object?> json) {
    return MemberListProjection(
      id: json[''id''] as String,
      memberCode: json[''member_code''] as String,
      memberName: json[''member_name''] as String,
      email: json[''email''] as String,
      phone: json[''phone''] as String,
      membershipType: json[''membership_type''] as String,
      joinedOn: DateTime.parse(json[''joined_on''] as String),
      validateTill: DateTime.parse(json[''validate_till''] as String),
      isActive: json[''is_active''] as bool,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''member_code'': memberCode,
    ''member_name'': memberName,
    ''email'': email,
    ''phone'': phone,
    ''membership_type'': membershipType,
    ''joined_on'': joinedOn.toIso8601String(),
    ''validate_till'': validateTill.toIso8601String(),
    ''is_active'': isActive,
  };
}
', '{"qualified_projection":"members.member:list","shape":"flat","kind":"list"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'summary', 'MemberSummaryProjection', 'lib/generated/projections/member_summary.dart', '// Generated projection DTO for members.member:summary.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class MemberSummaryProjection {
  const MemberSummaryProjection({
    required this.id,
    required this.email,
    required this.memberCode,
    required this.memberName,
  });

  final String id;
  final String email;
  final String memberCode;
  final String memberName;

  factory MemberSummaryProjection.fromJson(Map<String, Object?> json) {
    return MemberSummaryProjection(
      id: json[''id''] as String,
      email: json[''email''] as String,
      memberCode: json[''member_code''] as String,
      memberName: json[''member_name''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''email'': email,
    ''member_code'': memberCode,
    ''member_name'': memberName,
  };
}
', '{"qualified_projection":"members.member:summary","shape":"flat","kind":"summary"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'detail', 'MemberDetailProjection', 'lib/generated/projections/member_detail.dart', '// Generated projection DTO for members.member:detail.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class MemberDetailProjection {
  const MemberDetailProjection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.memberCode,
    required this.memberName,
    required this.email,
    required this.phone,
    required this.membershipType,
    required this.joinedOn,
    required this.validateTill,
    required this.isActive,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime archivedAt;
  final String createdBy;
  final String updatedBy;
  final String memberCode;
  final String memberName;
  final String email;
  final String phone;
  final String membershipType;
  final DateTime joinedOn;
  final DateTime validateTill;
  final bool isActive;

  factory MemberDetailProjection.fromJson(Map<String, Object?> json) {
    return MemberDetailProjection(
      id: json[''id''] as String,
      createdAt: DateTime.parse(json[''created_at''] as String),
      updatedAt: DateTime.parse(json[''updated_at''] as String),
      archivedAt: DateTime.parse(json[''archived_at''] as String),
      createdBy: json[''created_by''] as String,
      updatedBy: json[''updated_by''] as String,
      memberCode: json[''member_code''] as String,
      memberName: json[''member_name''] as String,
      email: json[''email''] as String,
      phone: json[''phone''] as String,
      membershipType: json[''membership_type''] as String,
      joinedOn: DateTime.parse(json[''joined_on''] as String),
      validateTill: DateTime.parse(json[''validate_till''] as String),
      isActive: json[''is_active''] as bool,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''created_at'': createdAt.toIso8601String(),
    ''updated_at'': updatedAt.toIso8601String(),
    ''archived_at'': archivedAt.toIso8601String(),
    ''created_by'': createdBy,
    ''updated_by'': updatedBy,
    ''member_code'': memberCode,
    ''member_name'': memberName,
    ''email'': email,
    ''phone'': phone,
    ''membership_type'': membershipType,
    ''joined_on'': joinedOn.toIso8601String(),
    ''validate_till'': validateTill.toIso8601String(),
    ''is_active'': isActive,
  };
}
', '{"qualified_projection":"members.member:detail","shape":"nested","kind":"detail"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'reference', 'MemberReferenceProjection', 'lib/generated/projections/member_reference.dart', '// Generated projection DTO for members.member:reference.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class MemberReferenceProjection {
  const MemberReferenceProjection({
    required this.id,
    required this.email,
    required this.memberCode,
    required this.memberName,
    required this.phone,
  });

  final String id;
  final String email;
  final String memberCode;
  final String memberName;
  final String phone;

  factory MemberReferenceProjection.fromJson(Map<String, Object?> json) {
    return MemberReferenceProjection(
      id: json[''id''] as String,
      email: json[''email''] as String,
      memberCode: json[''member_code''] as String,
      memberName: json[''member_name''] as String,
      phone: json[''phone''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''email'': email,
    ''member_code'': memberCode,
    ''member_name'': memberName,
    ''phone'': phone,
  };
}
', '{"qualified_projection":"members.member:reference","shape":"flat","kind":"reference"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#84de1f91e14d5258', 'members', 'member', 'picker', 'MemberPickerProjection', 'lib/generated/projections/member_picker.dart', '// Generated projection DTO for members.member:picker.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class MemberPickerProjection {
  const MemberPickerProjection({
    required this.id,
    required this.email,
    required this.memberName,
  });

  final String id;
  final String email;
  final String memberName;

  factory MemberPickerProjection.fromJson(Map<String, Object?> json) {
    return MemberPickerProjection(
      id: json[''id''] as String,
      email: json[''email''] as String,
      memberName: json[''member_name''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''email'': email,
    ''member_name'': memberName,
  };
}
', '{"qualified_projection":"members.member:picker","shape":"flat","kind":"picker"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;
