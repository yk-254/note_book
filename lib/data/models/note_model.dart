import '../../domain/entities/note.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final String categoryId;
  final int status; // 0=draft,1=completed
  final String createdAt;
  final String updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromDomain(Note n) {
    return NoteModel(
      id: n.id,
      title: n.title,
      content: n.content,
      categoryId: n.categoryId,
      status: n.status == NoteStatus.draft ? 0 : 1,
      createdAt: n.createdAt.toIso8601String(),
      updatedAt: n.updatedAt.toIso8601String(),
    );
  }

  Note toDomain() {
    return Note(
      id: id,
      title: title,
      content: content,
      categoryId: categoryId,
      status: status == 0 ? NoteStatus.draft : NoteStatus.completed,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'] as String,
    title: json['title'] as String,
    content: json['content'] as String,
    categoryId: json['categoryId'] as String,
    status: json['status'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'categoryId': categoryId,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
