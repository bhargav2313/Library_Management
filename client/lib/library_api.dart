// Talks to our Library API (port 8024). Plain Dart: no Flutter imports,
// so the same file works in the browser app and in a terminal script.
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:vyuh_blueprint_client/vyuh_blueprint_client.dart';
import 'package:vyuh_blueprint_protocol/vyuh_blueprint_protocol.dart';
import 'package:vyuh_query/vyuh_query.dart' as q;

/// Adds the header `Authorization: Bearer <token>` to every request.
class TokenClient extends http.BaseClient {
  TokenClient(this.token);
  final String token;
  final _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $token';
    return _inner.send(request);
  }

  @override
  void close() => _inner.close();
}

/// A random UUID (v4).
String newId() {
  final b = List.generate(16, (_) => Random.secure().nextInt(256));
  b[6] = (b[6] & 15) | 64;
  b[8] = (b[8] & 63) | 128;
  final s = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
  return '${s.substring(0, 8)}-${s.substring(8, 12)}-'
      '${s.substring(12, 16)}-${s.substring(16, 20)}-${s.substring(20)}';
}

class LibraryApi {
  LibraryApi({required this.base, required String token})
    : transport = TokenClient(token);

  final Uri base; // http://127.0.0.1:8024/api/
  final TokenClient transport;
  late final client = HttpBlueprintProtocolClient(base, httpClient: transport);

  /// Reads the manifest once and learns the revision (library:1.0).
  Future<void> connect() => client.connect();

  /// Runs the standard "create" action. Returns the new record's id.
  /// [type] is "module.entity", e.g. "category.category".
  Future<String> create(String type, Map<String, Object?> fields) async {
    final requestId = newId();
    final recordId = newId();
    final request = ActionRequest(
      id: requestId,
      source: RequestSource.ui,
      context: RequestContext(occurredAt: DateTime.now().toUtc()),
      resume: ActionResumePolicy(idempotencyKey: requestId),
      commands: [
        ActionCommand(
          id: requestId,
          module: type.split('.').first,
          entity: type.split('.').last,
          entityId: recordId,
          facet: BlueprintStandardAction.facet,
          action: 'create',
          payload: fields,
          idempotencyKey: requestId,
        ),
      ],
    );
    final response = await transport.post(
      base.resolve('actions/execute'),
      headers: {
        'Content-Type': ProtocolVersion.current.jsonMediaType,
        'Accept': ProtocolVersion.current.jsonMediaType,
        'Idempotency-Key': requestId,
        ProtocolHeaders.blueprintRevision: client.blueprintRevision!,
      },
      body: jsonEncode(actionRequestCodec.encode(request)),
    );
    final body = jsonDecode(response.body);
    if (response.statusCode != 200 ||
        body is! Map ||
        body['status'] != 'committed') {
      throw Exception('Save failed (${response.statusCode}): ${response.body}');
    }
    return recordId;
  }

  /// All rows of one entity, using its "list" projection.
  Future<List<Map<String, Object?>>> list(String type) async {
    final result = await client.queryEntity(
      BlueprintStudioQueryRequest(
        entityType: type,
        module: type.split('.').first,
        entity: type.split('.').last,
        projection: 'list',
        fetchMode: QueryFetchMode.refresh,
        query: q.CollectionRequest(
          source: q.EntitySource(entityType: type, projectionRef: 'list'),
          query: const q.Query(),
          arrangement: const q.Arrangement(),
          fetch: const q.OffsetFetchRequest(limit: 200, offset: 0),
        ),
      ),
    );
    return (result.result as q.CollectionResult).data
        .map((row) => row.values)
        .toList();
  }

  /// One row by id, using its "detail" projection.
  Future<Map<String, Object?>?> record(String type, String id) async {
    final result = await client.queryEntity(
      BlueprintStudioQueryRequest(
        entityType: type,
        module: type.split('.').first,
        entity: type.split('.').last,
        entityId: id,
        projection: 'detail',
        fetchMode: QueryFetchMode.refresh,
      ),
    );
    return (result.result as q.ItemResult).data?.values;
  }
}