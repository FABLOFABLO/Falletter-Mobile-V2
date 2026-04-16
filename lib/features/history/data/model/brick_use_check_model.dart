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
      targetUserId: json['targetUserId'],
      writerUserId: json['writerUserId'],
      gender: json['gender'],
      schoolNumber: json['schoolNumber'],
      createdAt: DateTime.parse(json['createdAt'] + 'Z').toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'amount': amount,
    'type': type,
    'question': question,
    'targetUserId': targetUserId,
    'writerUserId': writerUserId,
    'gender': gender,
    'schoolNumber': schoolNumber,
    'createdAt': createdAt,
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
    questionId : json['questionId'],
    targetUserId : json['targetUserId'],
    writerUserId : json['writerUserId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'amount': amount,
    'type': type,
    'questionId': questionId,
    'targetUserId': targetUserId,
    'writerUserId': writerUserId,
  };
}
