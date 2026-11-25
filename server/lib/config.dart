// Local settings.
//   Database: ../.env (shared with docker-compose.yml; created by ./tools/db up)
//   Dev token: .local/config.json (created here on first run)
// Both files are git-ignored.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:postgres/postgres.dart';

class LocalConfig {
  LocalConfig() {
    final manifest = File('pubspec.yaml');
    if (!manifest.existsSync() ||
        !manifest.readAsStringSync().contains('name: library_server')) {
      throw StateError('Run this command from the server/ directory.');
    }
    env = _readEnv(File('../.env'));
    final file = File('.local/config.json');
    if (!file.existsSync()) {
      file.parent.createSync(recursive: true);
      final token = base64UrlEncode(
        List.generate(32, (_) => Random.secure().nextInt(256)),
      );
      file.writeAsStringSync(jsonEncode({'token': token}));
      if (!Platform.isWindows) Process.runSync('chmod', ['600', file.path]);
    }
    values = (jsonDecode(file.readAsStringSync()) as Map)
        .cast<String, String>();
  }

  /// Values from ../.env, e.g. env['DB_PORT'].
  late final Map<String, String> env;
  late final Map<String, String> values;

  /// The one fixed development token the UI sends.
  String get token => values['token']!;

  static const apiPort = 8024;

  Endpoint get endpoint => Endpoint(
    host: env['DB_HOST'] ?? '127.0.0.1',
    port: int.parse(env['DB_PORT'] ?? '55433'),
    database: env['DB_NAME'] ?? 'library_dev',
    username: env['DB_USER'] ?? 'postgres',
    password: env['DB_PASSWORD'],
  );

  /// [ddl] uses simple mode so a whole .sql file can run as one script.
  Future<Connection> connect({bool ddl = false}) => Connection.open(
    endpoint,
    settings: ConnectionSettings(
      sslMode: SslMode.disable,
      queryMode: ddl ? QueryMode.simple : QueryMode.extended,
    ),
  );

  static Map<String, String> _readEnv(File file) {
    if (!file.existsSync()) {
      throw StateError('Missing .env — run ./tools/db up from the repo root.');
    }
    return {
      for (final line in file.readAsLinesSync())
        if (line.contains('=') && !line.trimLeft().startsWith('#'))
          line.substring(0, line.indexOf('=')).trim():
              line.substring(line.indexOf('=') + 1).trim(),
    };
  }
}
