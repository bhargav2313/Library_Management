// The whole app in one object: name, version and its modules.
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

import 'features/books.dart';
import 'features/category.dart';
import 'features/locations.dart';
import 'features/members.dart';

final libraryBlueprint = Blueprint(
  name: 'library',
  version: '1.0.0',
  title: 'Library',
  entityUI: const AppEntityUIScope.all(),
  shell: const AppShell(
    appearance: AppearanceUI(
      textScaleSteps: [0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5],
    ),
  ),

  modules: [
    categoryModule,
    booksModule,
    locationsModule,
    membersModule,
    // chaptersModule comes back after the Category + Book slice works.
    // Access decisions (who may run which action) belong to the "iam" module,
    // as in Learniq. It owns no tables of ours.
    const Module(name: 'iam', decidesAccess: true, entities: []),
  ],
);
