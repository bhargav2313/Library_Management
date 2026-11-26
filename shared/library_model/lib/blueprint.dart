// The whole app in one object: name, version and its modules.
import 'package:vyuh_blueprint/vyuh_blueprint.dart';

import 'features/books.dart';
import 'features/category.dart';
import 'features/locations.dart';

final libraryBlueprint = Blueprint(
  name: 'library',
  version: '1.0.0',
  title: 'Library',
  entityUI: const AppEntityUIScope.all(),

  modules: [
    categoryModule,
    booksModule,
    locationsModule,
    // chaptersModule comes back after the Category + Book slice works.
    // Access decisions (who may run which action) belong to the "iam" module,
    // as in Learniq. It owns no tables of ours.
    const Module(name: 'iam', decidesAccess: true, entities: []),
  ],
);
