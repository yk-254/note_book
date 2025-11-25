import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_app_getx_clean/domain/entities/note.dart';
import 'package:note_app_getx_clean/domain/repositories/note_repository.dart';
import 'package:note_app_getx_clean/presentation/controllers/note_controller.dart';

class MockRepo extends Mock implements NoteRepository {}

void main() {
  late NoteRepository repo;
  late NoteController controller;

  setUp(() {
    repo = MockRepo();
    controller = NoteController(repository: repo);
  });

  test('initial values', () {
    expect(controller.notes, isNotNull);
    expect(controller.categories, isNotNull);
  });

  // Add more tests: loadNotes, createNote, updateNote etc.
}
