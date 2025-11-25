import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes({String? categoryId, NoteStatus? status});
  Future<Note> createNote(Note note);
  Future<Note> updateNote(Note note);
  Future<void> deleteNote(String id);
  Future<List<String>> getCategories();
  Future<void> createCategory(String name);
}
