class AnnouncementModel {
  final int id;
  final String title;
  final String authorName;
  final DateTime createdAt;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.authorName,
    required this.createdAt
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
        id: json['id'],
        title: json['title'],
        authorName: json['authorName'],
        createdAt: DateTime.parse(json['createdAt'] + 'Z')
    );
  }
}