import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';
import '../../core/constants.dart';

class NoteRepositoryImpl implements NoteRepository {
  final GetStorage storage;

  NoteRepositoryImpl({required this.storage});

  List<NoteModel> _readAllModels() {
    final raw = storage.read(StorageKeys.notes) as List<dynamic>?;
    if (raw == null) return [];
    return raw.map((e) => NoteModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  Future<void> _saveAllModels(List<NoteModel> models) async {
    final list = models.map((m) => m.toJson()).toList();
    await storage.write(StorageKeys.notes, list);
  }

  @override
  Future<Note> createNote(Note note) async {
    final models = _readAllModels();
    final model = NoteModel.fromDomain(note);
    models.add(model);
    await _saveAllModels(models);
    return model.toDomain();
  }

  @override
  Future<void> deleteNote(String id) async {
    final models = _readAllModels();
    models.removeWhere((m) => m.id == id);
    await _saveAllModels(models);
  }

  @override
  Future<List<Note>> getNotes({String? categoryId, NoteStatus? status}) async {
    final models = _readAllModels();
    var filtered = models;
    if (categoryId != null) filtered = filtered.where((m) => m.categoryId == categoryId).toList();
    if (status != null) filtered = filtered.where((m) => m.status == (status == NoteStatus.draft ? 0 : 1)).toList();
    return filtered.map((m) => m.toDomain()).toList();
  }

  @override
  Future<Note> updateNote(Note note) async {
    final models = _readAllModels();
    final idx = models.indexWhere((m) => m.id == note.id);
    if (idx == -1) throw Exception('Note not found');
    models[idx] = NoteModel.fromDomain(note);
    await _saveAllModels(models);
    return models[idx].toDomain();
  }

  @override
  Future<List<String>> getCategories() async {
    final raw = storage.read(StorageKeys.categories) as List<dynamic>?;
    if (raw == null) return ['Personal', 'Work', 'University'];
    return raw.map((e) => e.toString()).toList();
  }

  @override
  Future<void> createCategory(String name) async {
    final raw = storage.read(StorageKeys.categories) as List<dynamic>?;
    final list = raw == null ? [] : raw.cast<String>().toList();
    if (!list.contains(name)) {
      list.add(name);
      await storage.write(StorageKeys.categories, list);
    }
  }
}
