class PostModel {
  final int id;
  final String title;
  final String content;
  final int authorId;
  final String authorName;
  final String anonymousNickname;
  final bool isDeleted;
  final int commentCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.anonymousNickname,
    required this.isDeleted,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        authorId: json['author']['user_id'],
        authorName: json['author']['name'],
        anonymousNickname: json['anonymous_nickname'],
        isDeleted: json['is_deleted'],
        commentCount: json['comment_count'],
        createdAt: DateTime.parse(json['created_at'] + 'Z').toLocal(),
        updatedAt: DateTime.parse(json['updated_at'] + 'Z').toLocal()
    );
  }
}