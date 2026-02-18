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
}