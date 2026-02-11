class PostDetailModel {
  final int id;
  final String title;
  final String content;
  final Author author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Comment> comment;

  PostDetailModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
  });

  factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    author: Author.fromJson(json["author"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    comment: List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "author": author.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
  };
}

class Author {
  final int userId;
  final String name;

  Author({
    required this.userId,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    userId: json["user_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
  };
}

class Comment {
  final int commentId;
  final Author user;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.commentId,
    required this.user,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    user: Author.fromJson(json["user"]),
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "user": user.toJson(),
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}