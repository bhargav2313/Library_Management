// Usage (from server/): ../tools/sdk dart run bin/server.dart emit|install|setup|token|serve
import 'dart:io';

import 'package:library_server/config.dart';
import 'package:library_server/schema.dart';
import 'package:library_server/app.dart';

Future<void> main(List<String> args) async {
  final config = LocalConfig();
  switch (args.firstOrNull) {
    case 'emit':
      await emitSchema();
    case 'install':
      await installSchema(config);
    case 'setup':
      await emitSchema();
      await installSchema(config);
    case 'token':
      stdout.writeln(config.token);
    case 'serve':
      await serve(config);
    default:
      stderr.writeln('Usage: dart run bin/server.dart emit|install|setup|token|serve');
      exitCode = 64;
  }
}