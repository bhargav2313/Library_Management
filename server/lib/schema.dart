// Turns the Blueprint into SQL (emit) and applies that SQL to PostgreSQL (install).
import 'dart:io';

import 'package:library_model/library_model.dart';
import 'package:vyuh_blueprint_server/blueprint_migrations.dart';
import 'package:vyuh_blueprint_server/vyuh_blueprint_server.dart';

import 'config.dart';
/// Blueprint's PostgreSQL support: knows how to write SQL for Postgres.
const database = PostgresDatabaseAdapter();
const runtimeSchema = 'library_runtime';
/// Our Blueprint + where Blueprint keeps its own bookkeeping tables.
final blueprintServer = BlueprintServer(
  blueprint: libraryBlueprint,
  runtimeSchema: runtimeSchema,
  database: database,
);

/// Generated SQL goes here. Never edit these files by hand.
const generatedDir = 'generated';

/// EMIT: Blueprint → SQL files in generated/.
Future<void> emitSchema() async {
  final files = await database.schema.emitBlueprint(
    blueprintServer,
    schemaDir: 'library',
  );
  final dir = Directory(generatedDir);
  if (dir.existsSync()) dir.deleteSync(recursive: true); // fresh every time
  for (final file in files.files) {
    final out = File('$generatedDir/${file.path}');
    out.parent.createSync(recursive: true);
    out.writeAsStringSync(file.sql);
  }
  stdout.writeln('Wrote ${files.files.length} files to $generatedDir/');
}

/// INSTALL: run the generated SQL against the database, once per version.
Future<void> installSchema(LocalConfig config) async {
  final paths = Directory(generatedDir)
      .listSync(recursive: true)
      .whereType<File>()
      .map((f) => f.path)
      .where((p) => p.endsWith('.sql'))
      .toList()
    ..sort(); // file names are numbered in install order
  if (paths.isEmpty) {
    throw StateError('Nothing to install: run "emit" first.');
  }
  final script = [for (final p in paths) File(p).readAsStringSync()]
      .join('\n\n');
  final connection = await config.connect();
  try {
    final outcome = await applyPostgresBlueprintMigration(
      connection,
      blueprint: 'library',
      version: libraryBlueprint.version, // '1.0.0'
      name: 'Category and Book',
      script: script,
    );
    stdout.writeln('Migration ${libraryBlueprint.version}: ${outcome.name}');
  } finally {
    await connection.close();
  }
}
//This file has two jobs: emitSchema() writes the SQL files, and installSchema() applies them to the database.