import 'dart:io';

import 'package:vyuh_blueprint_server/vyuh_blueprint_server.dart';
import 'package:vyuh_server/vyuh_server.dart';
import 'package:vyuh_server_plugin_postgres/vyuh_server_plugin_postgres.dart';

import 'auth.dart';
import 'config.dart';
import 'schema.dart';

Future<void> serve(LocalConfig config) async {
  final connection = await config.connect();

  final server = await VyuhServer.bootstrap(
    name: 'library',
    plugins: [
      PostgresDbPlugin.from(connection: connection), // 1. database
      DevAuthPlugin(config.token),                   // 2. who is calling
      BlueprintServerPlugin(                         // 3. API from the model
        name: 'library.blueprint',
        servers: [blueprintServer],
        basePath: '/api',
        persistence: const BlueprintPersistenceConfig(
          runtimeSchema: runtimeSchema,
        ),
      ),
    ],
  );

  await server.start(
    address: InternetAddress.loopbackIPv4,
    port: LocalConfig.apiPort, // 8024
    middleware: [
      GlobalMiddleware.cors(
        config: CorsConfig(
          origins: ['http://localhost:8023', 'http://127.0.0.1:8023'], // our UI
          exposedHeaders: [
            'Blueprint-Revision',
            'Blueprint-Revision-Current',
            'Blueprint-Idempotent-Replay',
          ],
        ),
      ),
      GlobalMiddleware.errorHandler(),
      GlobalMiddleware.auth(),
      GlobalMiddleware.requestLogger(),
    ],
    onShutdown: () async => connection.close(),
  );
  stdout.writeln('Library API: http://localhost:${LocalConfig.apiPort}/api/');
}