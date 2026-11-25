// Dev login: whoever sends "Authorization: Bearer <token from .local/config.json>"
// becomes the developer, allowed to create and read Category and Book.
import 'package:vyuh_server/vyuh_server.dart';

const devTenant = '11111111-1111-4111-8111-111111111111';
const devActor = '22222222-2222-4222-8222-222222222222';

// Grant names are <module>.<entity>.<action>
const devGrants = {
  'category.category.create',
  'category.category.read',
  'books.book.create',
  'books.book.read',
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
}