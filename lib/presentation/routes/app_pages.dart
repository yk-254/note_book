import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/notes_page.dart';
import '../pages/note_editor_page.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => const HomePage()),
    GetPage(name: Routes.NOTES, page: () => const NotesPage()),
    GetPage(name: Routes.EDITOR, page: () => const NoteEditorPage()),
  ];
}
