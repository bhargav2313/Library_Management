// Dev login: whoever sends "Authorization: Bearer <token from .local/config.json>"
// becomes the developer, allowed to create and read Category and Book.
import 'dart:convert';

import 'package:relic/relic.dart';
import 'package:vyuh_server/vyuh_server.dart';

const devTenant = '11111111-1111-4111-8111-111111111111';
const devActor = '22222222-2222-4222-8222-222222222222';

// Grant names are <module>.<entity>.<action>
const devGrants = {
  'category.category.create',
  'category.category.read',
  'books.book.create',
  'books.book.read',
  'locations.section.create',
  'locations.section.read',
  'locations.rack.create',
  'locations.rack.read',
};

/// Who the developer is. The Blueprint UI asks for this at start-up.
const devIdentity = {
  'id': devActor,
  'login_account_id': devActor,
  'directory_user_id': devActor,
  'display_name': 'Developer',
  'email': 'developer@library.local',
  'tenant_id': devTenant,
};

class DevTokenStrategy implements AuthStrategy {
  DevTokenStrategy(this.token);
  final String token;

  @override
  Future<Actor?> resolve(AuthContext context) async {
    final header = context.headers['authorization'];
    if (header == null) return null; // no header = anonymous
    if (header != 'Bearer $token') {
      throw const AuthFailed(reason: 'invalid_token', message: 'Wrong token.');
    }
    return UserActor(
      id: devActor,
      tenantId: devTenant,
      roles: devGrants,
      email: 'developer@library.local',
      source: 'local_development_token',
      claims: {'grants': devGrants.toList()},
    );
  }
}

class DevAuthPlugin extends AuthPlugin {
  DevAuthPlugin(String token) : strategies = [DevTokenStrategy(token)];
  @override
  String get name => 'library.dev_auth';
  @override
  final List<AuthStrategy> strategies;

  /// Auth routes the Blueprint UI needs. Its manifest must declare all four
  /// actions (login, refresh_session, current_subject, logout), or the UI
  /// refuses to start. In dev mode only "current_subject" (/me) really works:
  /// the app starts already signed in with the dev token.
  @override
  List<RouteSpec> get routes => [
    RouteSpec(
      method: 'GET',
      path: '/api/auth/manifest',
      handler: (Request req) async => _json(200, {
        'schema_version': '1.0',
        'entity_type': 'library.dev_account',
        'actions': [
          for (final (name, method, path) in [
            ('login', 'POST', 'login'),
            ('refresh_session', 'POST', 'refresh'),
            ('current_subject', 'GET', 'me'),
            ('logout', 'POST', 'logout'),
          ])
            {
              'ref': 'library.auth.$name',
              'name': name,
              'scope': 'record',
              'method': method,
              'path': '/api/auth/$path',
            },
        ],
      }),
    ),
    RouteSpec(
      method: 'GET',
      path: '/api/auth/me',
      handler: (Request req) async => req.actorOrNull?.id == devActor
          ? _json(200, devIdentity)
          : _json(401, {'message': 'Sign in again.'}),
    ),
    RouteSpec(
      method: 'POST',
      path: '/api/auth/login',
      handler: (Request req) async =>
          _json(401, {'message': 'Dev mode: start the app with the dev token.'}),
    ),
    RouteSpec(
      method: 'POST',
      path: '/api/auth/refresh',
      handler: (Request req) async =>
          _json(401, {'message': 'Dev mode: restart the app to sign in again.'}),
    ),
    RouteSpec(
      method: 'POST',
      path: '/api/auth/logout',
      handler: (Request req) async => _json(200, {'signed_out': true}),
    ),
  ];

  Response _json(int status, Map<String, Object?> body) => Response(
    status,
    headers: Headers.fromMap({
      'cache-control': ['no-store'],
    }),
    body: Body.fromString(jsonEncode(body), mimeType: MimeType.json),
  );
}