import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../controllers/note_controller.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final NoteController c = Get.find();
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  NoteStatus status = NoteStatus.draft;
  String? categoryId;
  String? editingId;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is Note) {
      final n = arg as Note;
      editingId = n.id;
      _titleCtrl.text = n.title;
      _contentCtrl.text = n.content;
      status = n.status;
      categoryId = n.categoryId;
    } else if (arg is Map && arg['category'] != null) {
      categoryId = arg['category'] as String;
    } else {
      categoryId = c.selectedCategory.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editingId == null ? 'New Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            Expanded(child: TextField(controller: _contentCtrl, decoration: const InputDecoration(labelText: 'Content'), maxLines: null, expands: true, keyboardType: TextInputType.multiline,)),
            Row(
              children: [
                DropdownButton<String>(
                  value: categoryId,
                  items: c.categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => categoryId = v),
                ),
                const SizedBox(width: 16),
                DropdownButton<NoteStatus>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: NoteStatus.draft, child: Text('Draft')),
                    DropdownMenuItem(value: NoteStatus.completed, child: Text('Completed')),
                  ],
                  onChanged: (v) => setState(() => status = v ?? NoteStatus.draft),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final title = _titleCtrl.text.trim();
                    final content = _contentCtrl.text.trim();
                    if (title.isEmpty) { Get.snackbar('Error', 'Title required'); return; }
                    if (editingId == null) {
                      await c.createNote(title: title, content: content, categoryId: categoryId ?? 'Personal', status: status);
                    } else {
                      final note = Note(id: editingId!, title: title, content: content, categoryId: categoryId ?? 'Personal', status: status, createdAt: DateTime.now(), updatedAt: DateTime.now());
                      await c.updateNote(note);
                    }
                    Get.back();
                  },
                  child: const Text('Save'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
