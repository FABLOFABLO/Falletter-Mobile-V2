class PostAuthor {
  final String name;

  PostAuthor({required this.name});
}

class PostModel {
  final int id;
  final String title;
  final String content;
  final PostAuthor author;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.updatedAt
  });
}