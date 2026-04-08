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
    authorId: json["author"]["userId"],
    authorName: json["author"]["name"],
    anonymousNickname: json["anonymousNickname"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"] + 'Z').toLocal(),
    updatedAt: DateTime.parse(json["updatedAt"] + 'Z').toLocal(),
    comment: (json["comment"] as List).map((x) => Comment.fromJson(x)).toList(),
  );
}

class Comment {
  final int commentId;
  final int userId;
  final String userName;
  final String anonymousNickname;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.anonymousNickname,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["commentId"],
    userId: json["user"]["userId"],
    userName: json["user"]["name"],
    anonymousNickname: json["anonymousNickname"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["createdAt"] + 'Z').toLocal(),
    updatedAt: DateTime.parse(json["updatedAt"] + 'Z').toLocal(),
  );
}