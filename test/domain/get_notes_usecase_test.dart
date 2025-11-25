import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_app_getx_clean/domain/entities/note.dart';
import 'package:note_app_getx_clean/domain/repositories/note_repository.dart';
import 'package:note_app_getx_clean/domain/usecases/get_notes_usecase.dart';

class MockRepo extends Mock implements NoteRepository {}

void main() {
  late NoteRepository repo;
  late GetNotesUseCase usecase;

  setUp(() {
    repo = MockRepo();
    usecase = GetNotesUseCase(repo);
  });

  test('calls repository with params', () async {
    when(() => repo.getNotes(categoryId: any(named: 'categoryId'), status: any(named: 'status')))
      .thenAnswer((_) async => <Note>[]);
    final res = await usecase.call(categoryId: 'c1');
    expect(res, isA<List<Note>>());
    verify(() => repo.getNotes(categoryId: 'c1', status: null)).called(1);
  });
}
