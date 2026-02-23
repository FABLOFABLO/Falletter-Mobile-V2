class LetterCountModel {
  final int letterCount;
  final int userId;

  LetterCountModel({required this.letterCount, required this.userId});

  factory LetterCountModel.fromJson(Map<String, dynamic> json) {
    return LetterCountModel(
      letterCount: json['letter_count'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'letter_count': letterCount,
    'user_id': userId,
  };
}
