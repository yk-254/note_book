import 'package:equatable/equatable.dart';

enum NoteStatus { draft, completed }

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String categoryId;
  final NoteStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? categoryId,
    NoteStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, title, content, categoryId, status, createdAt, updatedAt];
}
