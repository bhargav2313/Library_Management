import 'package:material_ui/material_ui.dart';
import 'package:library_model/library_model.dart';

import 'library_api.dart';

/// Create Category: Name + Description, then Save.
class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key, required this.api});
  final LibraryApi api;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  bool _saving = false;
  String? _message;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _message = null;
    });
    try {
      // Field names come from the SHARED model, never typed by hand.
      final id = await widget.api.create('category.category', {
        CategoryProperties.name.name: _name.text.trim(),
        CategoryProperties.description.name: _description.text.trim(),
      });
      // Read it back to show the code the SERVER generated.
      final saved = await widget.api.record('category.category', id);
      _name.clear();
      _description.clear();
      _message = 'Saved ${saved?[CategoryProperties.code.name]}';
    } catch (e) {
      _message = '$e';
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Category Code: generated on save (CAT-00001, ...)'),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(
              labelText: '${CategoryProperties.name.title} *',
            ),
            maxLength: 150,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          TextFormField(
            controller: _description,
            decoration: InputDecoration(
              labelText: CategoryProperties.description.title,
            ),
            maxLines: 3,
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