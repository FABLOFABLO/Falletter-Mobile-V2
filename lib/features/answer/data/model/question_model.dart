class QuestionModel {
  final int id;
  final String question;
  final String emoji;

  QuestionModel({
    required this.id,
    required this.question,
    required this.emoji
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'],
        question: json['question'],
        emoji: json['emoji']
    );
  }
}