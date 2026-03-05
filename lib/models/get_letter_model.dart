import 'package:falletter_mobile_v2/models/student_model.dart';

class GetLetterModel {
  final int id;
  final String content;
  final bool isDelivered;
  final bool isPassed;
  final int receptionId;
  final int senderId;
  final DateTime createdAt;
  final StudentModel? get;

  GetLetterModel({
    required this.id,
    required this.content,
    required this.isDelivered,
    required this.isPassed,
    required this.receptionId,
    required this.senderId,
    required this.createdAt,
    this.get,
  });

  factory GetLetterModel.fromJson(Map<String, dynamic> json) {
    return GetLetterModel(
      id: json['id'],
      content: json['content'],
      isDelivered: json['is_delivered'],
      isPassed: json['is_passed'],
      receptionId: json['reception_id'],
      senderId: json['sender_id'],
      createdAt: DateTime.parse(json['create_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_delivered': isDelivered,
      'is_passed': isPassed,
      'reception_id': receptionId,
      'sender_id': senderId,
      'created_at': createdAt,
    };
  }
}
