class LetterCountModel {
  final int userId;
  final int letterCount;

  LetterCountModel({required this.userId, required this.letterCount});

  factory LetterCountModel.fromJson(Map<String, dynamic> json) {
    return LetterCountModel(
      userId: json['userId'],
      letterCount: json['letterCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'letterCount': letterCount,
  };

  LetterCountModel copyWith({int? userId, int? letterCount}) {
    return LetterCountModel(
      userId: userId ?? this.userId,
      letterCount: letterCount ?? this.letterCount,
    );
  }
}
