import 'package:material_ui/material_ui.dart';

import 'book_form.dart';
import 'category_form.dart';
import 'library_api.dart';

// Given at start-up with --dart-define (see the run command).
const apiBase = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://127.0.0.1:8024/api/',
);
const apiToken = String.fromEnvironment('API_TOKEN');

void main() => runApp(const LibraryApp());

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Library',
    theme: ThemeData(colorSchemeSeed: Colors.indigo),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = LibraryApi(base: Uri.parse(apiBase), token: apiToken);
  late final Future<void> connecting = api.connect();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Create Category'), Tab(text: 'Create Book')],
          ),
        ),
        body: FutureBuilder(
          future: connecting,
          builder: (context, snapshot) {
            if (apiToken.isEmpty) {
              return const Center(child: Text('Start the app with --dart-define=API_TOKEN=...'));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Cannot reach the API: ${snapshot.error}'));
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return TabBarView(
              children: [CategoryForm(api: api), BookForm(api: api)],
            );
          },
        ),
      ),
    );
  }
}