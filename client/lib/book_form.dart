import 'package:material_ui/material_ui.dart';
import 'package:library_model/library_model.dart';

import 'library_api.dart';

/// Create Book: Name, Author and a Category dropdown, then Save.
class BookForm extends StatefulWidget {
  const BookForm({super.key, required this.api});
  final LibraryApi api;

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _author = TextEditingController();
  List<Map<String, Object?>> _categories = [];
  String? _categoryId; // the uuid we send as category_id
  bool _saving = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  /// Fills the dropdown from the API (the "list" projection of Category).
  Future<void> _loadCategories() async {
    try {
      final rows = await widget.api.list('category.category');
      setState(() => _categories = rows);
    } catch (e) {
      setState(() => _message = 'Could not load categories: $e');
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _message = null;
    });
    try {
      final id = await widget.api.create('books.book', {
        BookProperties.name.name: _name.text.trim(),
        BookProperties.categoryId.name: _categoryId, // the foreign key
        BookProperties.author.name: _author.text.trim(),
      });
      final saved = await widget.api.record('books.book', id);
      _name.clear();
      _author.clear();
      _message = 'Saved ${saved?[BookProperties.code.name]}';
    } catch (e) {
      _message = '$e';
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _author.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Book Code: generated on save (BK-00001, ...)'),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(
              labelText: '${BookProperties.name.title} *',
            ),
            maxLength: 150,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _categoryId,
                  decoration: InputDecoration(
                    labelText: '${BookProperties.categoryId.title} *',
                  ),
                  items: [
                    for (final c in _categories)
                      DropdownMenuItem(
                        value: '${c['id']}',
                        child: Text(
                          '${c[CategoryProperties.code.name]}  '
                          '${c[CategoryProperties.name.name]}',
                        ),
                      ),
                  ],
                  onChanged: (v) => setState(() => _categoryId = v),
                  validator: (v) => v == null ? 'Pick a category' : null,
                ),
              ),
              IconButton(
                tooltip: 'Reload categories',
                onPressed: _loadCategories,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          TextFormField(
            controller: _author,
            decoration: InputDecoration(labelText: BookProperties.author.title),
            maxLength: 150,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Saving...' : 'Save'),
          ),
          if (_message != null) ...[
            const SizedBox(height: 16),
            Text(_message!),
          ],
        ],
      ),
    );
  }
}