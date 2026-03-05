class BrickUseCheckModel {
  final int id;
  final String description;
  final int amount;
  final String type;
  final String question;
  final int targetUserId;
  final int writerUserId;
  final String gender;
  final String schoolNumber;
  final DateTime createdAt;

  BrickUseCheckModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.question,
    required this.targetUserId,
    required this.writerUserId,
    required this.gender,
    required this.schoolNumber,
    required this.createdAt,
  });

  factory BrickUseCheckModel.fromJson(Map<String, dynamic> json) {
    return BrickUseCheckModel(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      type: json['type'],
      question: json['question'],
      targetUserId: json['target_user_id'],
      writerUserId: json['writer_user_id'],
      gender: json['gender'],
      schoolNumber: json['school_number'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'amount': amount,
    'type': type,
    'question': question,
    'target_user_id': targetUserId,
    'writer_user_id': writerUserId,
    'gender': gender,
    'school_number': schoolNumber,
    'created_at': createdAt,
  };
}

class SaveBrickModel {
  final String title;
  final String description;
  final int amount;
  final String type;
  final int questionId;
  final int targetUserId;
  final int writerUserId;

  SaveBrickModel({
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.questionId,
    required this.targetUserId,
    required this.writerUserId,
  });

 factory SaveBrickModel.fromJson(Map<String, dynamic> json) {
    return SaveBrickModel(
    title: json['title'],
    description: json['description'],
    amount : json['amount'],
    type : json['type'],
    questionId : json['question_id'],
    targetUserId : json['target_user_id'],
    writerUserId : json['writer_user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'amount': amount,
    'type': type,
    'question_id': questionId,
    'target_user_id': targetUserId,
    'writer_user_id': writerUserId,
  };
}
