import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController c = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('دسته‌بندی‌ها')),
      body: Obx(() {
        return ListView.builder(
          itemCount: c.categories.length,
          itemBuilder: (context, i) {
            final cat = c.categories[i];
            return ListTile(
              title: Text(cat),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                c.setCategory(cat);
                Get.toNamed(Routes.NOTES, arguments: cat);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (ctx) {
            final ctrl = TextEditingController();
            return AlertDialog(
              title: const Text('افزودن دسته‌بندی'),
              content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'نام دسته')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('لغو')),
                TextButton(onPressed: () async {
                  if (ctrl.text.trim().isNotEmpty) {
                    await c.addCategory(ctrl.text.trim());
                    Navigator.pop(ctx);
                  }
                }, child: const Text('افزودن')),
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
