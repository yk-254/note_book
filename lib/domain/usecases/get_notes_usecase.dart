import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase {
  final NoteRepository repository;
  GetNotesUseCase(this.repository);

  Future<List<Note>> call({String? categoryId, NoteStatus? status}) {
    return repository.getNotes(categoryId: categoryId, status: status);
  }
}
