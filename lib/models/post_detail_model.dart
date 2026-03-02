class PostDetailModel {
  final int id;
  final String title;
  final String content;
  final int authorId;
  final String authorName;
  final String anonymousNickname;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Comment> comment;

  PostDetailModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.anonymousNickname,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
  });

  factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    authorId: json["author"]["user_id"],
    authorName: json["author"]["name"],
    anonymousNickname: json["anonymous_nickname"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"] + 'Z').toLocal(),
    updatedAt: DateTime.parse(json["updated_at"] + 'Z').toLocal(),
    comment: (json["comment"] as List ?? []).map((x) => Comment.fromJson(x)).toList(),
  );
}

class Comment {
  final int commentId;
  final int userId;
  final String userName;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    userId: json["user"]["user_id"],
    userName: json["user"]["name"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"] + 'Z').toLocal(),
    updatedAt: DateTime.parse(json["updated_at"] + 'Z').toLocal(),
  );
}