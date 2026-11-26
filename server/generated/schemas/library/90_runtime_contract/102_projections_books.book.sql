-- GENERATED from library blueprint by vyuh_blueprint. Do not edit.

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'list', 'list', 'flat', '[{"facet":"system","projection":"list","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"list","fields":[{"facet":"identity","statePath":"identity.book_code","flatName":"book_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_code"}},{"facet":"identity","statePath":"identity.book_name","flatName":"book_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_name"}},{"facet":"identity","statePath":"identity.category_id","flatName":"category_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_id"}},{"facet":"identity","statePath":"identity.author","flatName":"author","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.author"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'summary', 'summary', 'flat', '[{"facet":"system","projection":"summary","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"summary","fields":[{"facet":"identity","statePath":"identity.book_code","flatName":"book_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_code"}},{"facet":"identity","statePath":"identity.book_name","flatName":"book_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_name"}},{"facet":"identity","statePath":"identity.category_id","flatName":"category_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_id"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'detail', 'detail', 'nested', '[{"facet":"system","projection":"detail","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}},{"facet":"system","statePath":"system.created_at","flatName":"created_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.created_at"}},{"facet":"system","statePath":"system.updated_at","flatName":"updated_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.updated_at"}},{"facet":"system","statePath":"system.archived_at","flatName":"archived_at","type":"timestamp","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.archived_at"}},{"facet":"system","statePath":"system.created_by","flatName":"created_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.created_by"}},{"facet":"system","statePath":"system.updated_by","flatName":"updated_by","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":true,"metadata":{"source_path":"system.properties.updated_by"}}]},{"facet":"identity","projection":"detail","fields":[{"facet":"identity","statePath":"identity.book_code","flatName":"book_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_code"}},{"facet":"identity","statePath":"identity.book_name","flatName":"book_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_name"}},{"facet":"identity","statePath":"identity.category_id","flatName":"category_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_id"}},{"facet":"identity","statePath":"identity.author","flatName":"author","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.author"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'reference', 'reference', 'flat', '[{"facet":"system","projection":"reference","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"reference","fields":[{"facet":"identity","statePath":"identity.book_code","flatName":"book_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_code"}},{"facet":"identity","statePath":"identity.book_name","flatName":"book_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_name"}},{"facet":"identity","statePath":"identity.category_id","flatName":"category_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_id"}},{"facet":"identity","statePath":"identity.author","flatName":"author","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.author"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.entity_projections (revision_id, module, entity, projection, kind, shape, facets, actions, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'picker', 'picker', 'flat', '[{"facet":"system","projection":"picker","fields":[{"facet":"system","statePath":"system.id","flatName":"id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"system.properties.id"}}]},{"facet":"identity","projection":"picker","fields":[{"facet":"identity","statePath":"identity.book_code","flatName":"book_code","type":"text","filterable":true,"sortable":true,"searchable":true,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_code"}},{"facet":"identity","statePath":"identity.book_name","flatName":"book_name","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.book_name"}},{"facet":"identity","statePath":"identity.category_id","flatName":"category_id","type":"uuid","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.category_id"}},{"facet":"identity","statePath":"identity.author","flatName":"author","type":"text","filterable":true,"sortable":true,"searchable":false,"groupable":true,"hidden":false,"metadata":{"source_path":"identity.properties.author"}}]}]'::jsonb, '[]'::jsonb, '{}'::jsonb) ON CONFLICT (revision_id, module, entity, projection) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'list', 'BookListProjection', 'lib/generated/projections/book_list.dart', '// Generated projection DTO for books.book:list.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class BookListProjection {
  const BookListProjection({
    required this.id,
    required this.bookCode,
    required this.bookName,
    required this.categoryId,
    required this.author,
  });

  final String id;
  final String bookCode;
  final String bookName;
  final String categoryId;
  final String author;

  factory BookListProjection.fromJson(Map<String, Object?> json) {
    return BookListProjection(
      id: json[''id''] as String,
      bookCode: json[''book_code''] as String,
      bookName: json[''book_name''] as String,
      categoryId: json[''category_id''] as String,
      author: json[''author''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''book_code'': bookCode,
    ''book_name'': bookName,
    ''category_id'': categoryId,
    ''author'': author,
  };
}
', '{"qualified_projection":"books.book:list","shape":"flat","kind":"list"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'summary', 'BookSummaryProjection', 'lib/generated/projections/book_summary.dart', '// Generated projection DTO for books.book:summary.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class BookSummaryProjection {
  const BookSummaryProjection({
    required this.id,
    required this.bookCode,
    required this.bookName,
    required this.categoryId,
  });

  final String id;
  final String bookCode;
  final String bookName;
  final String categoryId;

  factory BookSummaryProjection.fromJson(Map<String, Object?> json) {
    return BookSummaryProjection(
      id: json[''id''] as String,
      bookCode: json[''book_code''] as String,
      bookName: json[''book_name''] as String,
      categoryId: json[''category_id''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''book_code'': bookCode,
    ''book_name'': bookName,
    ''category_id'': categoryId,
  };
}
', '{"qualified_projection":"books.book:summary","shape":"flat","kind":"summary"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'detail', 'BookDetailProjection', 'lib/generated/projections/book_detail.dart', '// Generated projection DTO for books.book:detail.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class BookDetailProjection {
  const BookDetailProjection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.archivedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.bookCode,
    required this.bookName,
    required this.categoryId,
    required this.author,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime archivedAt;
  final String createdBy;
  final String updatedBy;
  final String bookCode;
  final String bookName;
  final String categoryId;
  final String author;

  factory BookDetailProjection.fromJson(Map<String, Object?> json) {
    return BookDetailProjection(
      id: json[''id''] as String,
      createdAt: DateTime.parse(json[''created_at''] as String),
      updatedAt: DateTime.parse(json[''updated_at''] as String),
      archivedAt: DateTime.parse(json[''archived_at''] as String),
      createdBy: json[''created_by''] as String,
      updatedBy: json[''updated_by''] as String,
      bookCode: json[''book_code''] as String,
      bookName: json[''book_name''] as String,
      categoryId: json[''category_id''] as String,
      author: json[''author''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''created_at'': createdAt.toIso8601String(),
    ''updated_at'': updatedAt.toIso8601String(),
    ''archived_at'': archivedAt.toIso8601String(),
    ''created_by'': createdBy,
    ''updated_by'': updatedBy,
    ''book_code'': bookCode,
    ''book_name'': bookName,
    ''category_id'': categoryId,
    ''author'': author,
  };
}
', '{"qualified_projection":"books.book:detail","shape":"nested","kind":"detail"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'reference', 'BookReferenceProjection', 'lib/generated/projections/book_reference.dart', '// Generated projection DTO for books.book:reference.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class BookReferenceProjection {
  const BookReferenceProjection({
    required this.id,
    required this.bookCode,
    required this.bookName,
    required this.categoryId,
    required this.author,
  });

  final String id;
  final String bookCode;
  final String bookName;
  final String categoryId;
  final String author;

  factory BookReferenceProjection.fromJson(Map<String, Object?> json) {
    return BookReferenceProjection(
      id: json[''id''] as String,
      bookCode: json[''book_code''] as String,
      bookName: json[''book_name''] as String,
      categoryId: json[''category_id''] as String,
      author: json[''author''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''book_code'': bookCode,
    ''book_name'': bookName,
    ''category_id'': categoryId,
    ''author'': author,
  };
}
', '{"qualified_projection":"books.book:reference","shape":"flat","kind":"reference"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;

INSERT INTO library_runtime.projection_sources (revision_id, module, entity, projection, class_name, path, source, metadata) VALUES ('library:1.0.0#fdddb97aee65b3d4', 'books', 'book', 'picker', 'BookPickerProjection', 'lib/generated/projections/book_picker.dart', '// Generated projection DTO for books.book:picker.
// Source of truth: BlueprintRuntimeArtifactCompiler.

final class BookPickerProjection {
  const BookPickerProjection({
    required this.id,
    required this.bookCode,
    required this.bookName,
    required this.categoryId,
    required this.author,
  });

  final String id;
  final String bookCode;
  final String bookName;
  final String categoryId;
  final String author;

  factory BookPickerProjection.fromJson(Map<String, Object?> json) {
    return BookPickerProjection(
      id: json[''id''] as String,
      bookCode: json[''book_code''] as String,
      bookName: json[''book_name''] as String,
      categoryId: json[''category_id''] as String,
      author: json[''author''] as String,
    );
  }

  Map<String, Object?> toJson() => {
    ''id'': id,
    ''book_code'': bookCode,
    ''book_name'': bookName,
    ''category_id'': categoryId,
    ''author'': author,
  };
}
', '{"qualified_projection":"books.book:picker","shape":"flat","kind":"picker"}'::jsonb) ON CONFLICT (revision_id, module, entity, projection, class_name) DO NOTHING;
