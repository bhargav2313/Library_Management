// Creates one Category through the API. The server must be running.
// Run from server/:  ../tools/sdk dart run bin/create_category.dart "Fiction"
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:library_server/config.dart';
import 'package:vyuh_blueprint_client/vyuh_blueprint_client.dart';
import 'package:vyuh_blueprint_protocol/vyuh_blueprint_protocol.dart';

/// Adds "Authorization: Bearer <token>" to every request it sends.
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

/// A random UUID (v4), used as the new row's id and as the request id.
String newId() {
  final b = List.generate(16, (_) => Random.secure().nextInt(256));
  b[6] = (b[6] & 15) | 64;
  b[8] = (b[8] & 63) | 128;
  final s = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
  return '${s.substring(0, 8)}-${s.substring(8, 12)}-'
      '${s.substring(12, 16)}-${s.substring(16, 20)}-${s.substring(20)}';
}

Future<void> main(List<String> args) async {
  final name = args.isEmpty ? 'Fiction' : args.first;
  final config = LocalConfig();
  final base = Uri.parse('http://127.0.0.1:${LocalConfig.apiPort}/api/');
  final transport = TokenClient(config.token);

  // 1. CONNECT: reads the manifest and learns the revision ("library:1.0").
  final client = HttpBlueprintProtocolClient(base, httpClient: transport);
  await client.connect();
  print('Connected. Revision: ${client.blueprintRevision}');

  // 2. BUILD: one "create" command for category.category.
  final requestId = newId();
  final categoryId = newId();
  final request = ActionRequest(
    id: requestId,
    source: RequestSource.ui,
    context: RequestContext(occurredAt: DateTime.now().toUtc()),
    resume: ActionResumePolicy(idempotencyKey: requestId),
    commands: [
      ActionCommand(
        id: requestId,
        module: 'category',
        entity: 'category',
        entityId: categoryId,
        facet: BlueprintStandardAction.facet,
        action: 'create',
        payload: {
          'category_name': name,
          'description': 'Created by create_category.dart',
        },
        idempotencyKey: requestId,
      ),
    ],
  );

  // 3. SEND it to POST /api/actions/execute.
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
  print('HTTP ${response.statusCode}');
  print(response.body);
  transport.close();
}