class SendLetterModel {
  final int id;
  final String content;
  final int receptionId;
  final int senderId;
  final bool isDelivered;
  final bool isPassed;
  final DateTime createdAt;

  SendLetterModel({
    required this.id,
    required this.content,
    required this.receptionId,
    required this.senderId,
    required this.isDelivered,
    required this.isPassed,
    required this.createdAt,
  });

  factory SendLetterModel.fromJson(Map<String, dynamic> json) {
    return SendLetterModel(
      id: json['id'],
      content: json['content'],
      receptionId: json['receptionId'],
      senderId: json['senderId'],
      isDelivered: json['isDelivered'],
      isPassed: json['isPassed'],
      createdAt: DateTime.parse(json['createdAt'] + 'Z').toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'receptionId': receptionId,
      'isDelivered': isDelivered,
      'isPassed': isPassed,
      'createdAt': createdAt,
    };
  }
}
