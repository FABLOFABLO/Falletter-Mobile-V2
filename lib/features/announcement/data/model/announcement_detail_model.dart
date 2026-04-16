class AnnouncementDetailModel {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final DateTime createdAt;

  AnnouncementDetailModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.createdAt
  });

  factory AnnouncementDetailModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementDetailModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        authorName: json["author_name"],
        createdAt: json["created_at"]
    );
  }
}