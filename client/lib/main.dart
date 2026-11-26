// The Category + Book app. Every screen and form is built by
// Blueprint UI from the shared model. We write no forms here.
//
// Run: flutter run -d web-server --web-port 8023
//        --dart-define=API_TOKEN=<token>
import 'package:library_model/library_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vyuh_blueprint_protocol/vyuh_blueprint_protocol.dart';
import 'package:vyuh_blueprint_ui/auth.dart';
import 'package:vyuh_blueprint_ui/vyuh_blueprint_ui.dart';
import 'package:vyuh_core/vyuh_core.dart' as vc;

import 'library_api.dart' show TokenClient;

const apiBase = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://127.0.0.1:8024/api/',
);
const apiToken = String.fromEnvironment('API_TOKEN');

// Must match devActor / devTenant / devGrants in server/lib/auth.dart.
const devActor = '22222222-2222-4222-8222-222222222222';
const devTenant = '11111111-1111-4111-8111-111111111111';
const devGrants = [
  'category.category.create',
  'category.category.read',
  'books.book.create',
  'books.book.read',
  'locations.section.create',
  'locations.section.read',
  'locations.rack.create',
  'locations.rack.read',
];

/// A ready-made "signed in" session built from the dev token, so the app
/// starts signed in. A real app gets this from a login screen instead.
Map<String, Object?> devSession() => {
  'identity': {
    'id': devActor,
    'login_account_id': devActor,
    'directory_user_id': devActor,
    'display_name': 'Developer',
    'email': 'developer@library.local',
    'tenant_id': devTenant,
  },
  'actor_id': devActor,
  'session_id': devActor,
  'grants': devGrants,
  'tokens': {
    'access_token': apiToken,
    'refresh_token': '',
    'expires_at': DateTime.now().toUtc().add(const Duration(hours: 8)).toIso8601String(),
  },
  'session_policy': {
    'absolute_timeout_seconds': 28800,
    'inactivity_timeout_seconds': 28800,
    'authority_activity': false,
  },
};

Widget _message(String text) =>
    Scaffold(body: Center(child: Text(text, textAlign: TextAlign.center)));

/// The screens Blueprint UI shows around sign-in. We keep them minimal.
final surfaces = BlueprintAuthenticationSurfaces(
  signIn: (context, auth) => _message('Signed out. Restart the app.'),
  resolving: (context, auth, {required wait, onSignOut}) =>
      const Scaffold(body: Center(child: CircularProgressIndicator())),
  serviceError: (context, auth) => _message('The API is not reachable.'),
  passwordChange: (context, auth) => _message('Not used in dev mode.'),
  sessionWarning: (context, auth) => _message('Session ending.'),
  sessionUnsavedNotice: (context, auth, {required child}) => child,
  workspaceLoadFailed: (context, auth, {required load, required onSignOut}) =>
      Scaffold(
        body: Center(
          child: FilledButton(onPressed: load.retry, child: const Text('Retry')),
        ),
      ),
  contactAdministrator: (context, plugin,
          {initialName = '', initialEmail = '', submittedFrom = ''}) async =>
      null,
  signature: (context, request) async => false,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final base = Uri.parse(apiBase);

  // 1. The session: start already signed in with the dev token.
  final store = InMemoryBlueprintAuthSessionStore();
  await store.write(BlueprintAuthenticationSession.fromJson(devSession()));
  final auth = BlueprintAuthPlugin(
    authBase: base.resolve('auth/'),
    environment: 'local-dev',
    sessionStore: store,
  );

  // 2. The protocol client: every API call carries the token.
  final client = HttpBlueprintProtocolClient(
    base,
    httpClient: TokenClient(apiToken),
  );

  // 3. Blueprint UI builds the whole app from the shared libraryBlueprint.
  BlueprintApp.run(
    base,
    client: () => client,
    plugins: vc.PluginDescriptor(auth: auth),
    devTools: false,
    features: [
      vc.FeatureDescriptor(
        name: 'library',
        title: 'Library',
        routes: () => [],
        extensions: [
          BlueprintClientDescriptor(
            blueprints: [libraryBlueprint],
            authenticationSurfaces: surfaces,
          ),
        ],
      ),
    ],
  );
}
