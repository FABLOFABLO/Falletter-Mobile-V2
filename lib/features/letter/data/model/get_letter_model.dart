class GetLetterModel {
  final int id;
  final String content;
  final bool isDelivered;
  final bool isPassed;
  final int receptionId;
  final int senderId;
  final DateTime createdAt;

  GetLetterModel({
    required this.id,
    required this.content,
    required this.isDelivered,
    required this.isPassed,
    required this.receptionId,
    required this.senderId,
    required this.createdAt,
  });

  factory GetLetterModel.fromJson(Map<String, dynamic> json) {
    return GetLetterModel(
      id: json['id'],
      content: json['content'],
      isDelivered: json['isDelivered'],
      isPassed: json['isPassed'],
      receptionId: json['receptionId'],
      senderId: json['senderId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isDelivered': isDelivered,
      'isPassed': isPassed,
      'receptionId': receptionId,
      'senderId': senderId,
      'createdAt': createdAt,
    };
  }
}
