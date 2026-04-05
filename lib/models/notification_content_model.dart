class NotificationContentModel {
  final int id;
  final String type;
  final String title;
  final String body;
  final String imageUrl;
  final int? relatedId;
  final DateTime createdAt;
  final DateTime expiredAt;

  NotificationContentModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.relatedId,
    required this.createdAt,
    required this.expiredAt,
  });

  factory NotificationContentModel.fromJson(Map<String, dynamic> json) {
    return NotificationContentModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['imageUrl'],
      relatedId: json['relatedId'],
      createdAt: DateTime.parse(json['createdAt'] + 'Z').toLocal(),
      expiredAt: DateTime.parse(json['expiredAt'] + 'Z').toLocal(),
    );
  }
}
