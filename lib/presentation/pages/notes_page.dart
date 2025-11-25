import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../controllers/note_controller.dart';
import '../routes/app_pages.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController c = Get.find();
    final arg = Get.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text(arg ?? 'Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: c.selectedCategory.value ?? arg,
                  items: c.categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => c.setCategory(v),
                ),
                const SizedBox(width: 16),
                PopupMenuButton<NoteStatus?>(
                  onSelected: (s) => c.setFilterStatus(s),
                  itemBuilder: (_) => [
                    const PopupMenuItem(value: null, child: Text('All')),
                    const PopupMenuItem(value: NoteStatus.draft, child: Text('Draft')),
                    const PopupMenuItem(value: NoteStatus.completed, child: Text('Completed')),
                  ],
                  child: const Icon(Icons.filter_list),
                )
              ],
            ),
          ),
          Expanded(child: Obx(() {
            final list = c.notes;
            if (list.isEmpty) return const Center(child: Text('No notes'));
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final n = list[i];
                return Dismissible(
                  key: Key(n.id),
                  background: Container(color: Colors.red, child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(alignment: Alignment.centerLeft, child: Icon(Icons.delete)),
                  )),
                  onDismissed: (_) async {
                    await c.deleteNote(n.id);
                    Get.snackbar('Deleted', 'Note deleted', snackPosition: SnackPosition.BOTTOM);
                  },
                  child: ListTile(
                    title: Text(n.title),
                    subtitle: Text(n.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: Icon(n.status == NoteStatus.completed ? Icons.check_circle : Icons.circle_outlined),
                    onTap: () => Get.toNamed(Routes.EDITOR, arguments: n),
                  ),
                );
              },
            );
          }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cat = c.selectedCategory.value ?? arg ?? (c.categories.isNotEmpty ? c.categories.first : 'Personal');
          Get.toNamed(Routes.EDITOR, arguments: {'category': cat});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
