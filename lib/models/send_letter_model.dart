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
      receptionId: json['reception_id'],
      senderId: json['sender_id'],
      isDelivered: json['is_delivered'],
      isPassed: json['is_passed'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'reception_id': receptionId,
      'is_delivered': isDelivered,
      'is_passed': isPassed,
      'created_at': createdAt,
    };
  }
}
