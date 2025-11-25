import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';

class NoteController extends GetxController {
  final NoteRepository repository;
  NoteController({required this.repository});

  final notes = <Note>[].obs;
  final categories = <String>[].obs;
  final selectedCategory = RxnString();
  final filterStatus = Rxn<NoteStatus>();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadNotes();
  }

  Future<void> loadCategories() async {
    final res = await repository.getCategories();
    categories.assignAll(res);
    if (categories.isNotEmpty && selectedCategory.value == null) {
      selectedCategory.value = categories.first;
    }
  }

  Future<void> loadNotes() async {
    final cats = selectedCategory.value;
    final status = filterStatus.value;
    final res = await repository.getNotes(categoryId: cats, status: status);
    notes.assignAll(res);
  }

  Future<void> addCategory(String name) async {
    await repository.createCategory(name);
    await loadCategories();
  }

  Future<Note> createNote({required String title, required String content, required String categoryId, NoteStatus status = NoteStatus.draft}) async {
    final id = const Uuid().v4();
    final now = DateTime.now();
    final note = Note(id: id, title: title, content: content, categoryId: categoryId, status: status, createdAt: now, updatedAt: now);
    final created = await repository.createNote(note);
    await loadNotes();
    return created;
  }

  Future<Note> updateNote(Note n) async {
    final updated = await repository.updateNote(n.copyWith(updatedAt: DateTime.now()));
    await loadNotes();
    return updated;
  }

  Future<void> deleteNote(String id) async {
    await repository.deleteNote(id);
    await loadNotes();
  }

  void setCategory(String? cat) {
    selectedCategory.value = cat;
    loadNotes();
  }

  void setFilterStatus(NoteStatus? s) {
    filterStatus.value = s;
    loadNotes();
  }
}
