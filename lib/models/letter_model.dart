class LetterModel {
  final String content;
  final int receptionId;

  LetterModel({required this.content, required this.receptionId});

  factory LetterModel.fromJson(Map<String, dynamic> json) {
    return LetterModel(
      content: json['content'],
      receptionId: json['receptionId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content,
    'receptionId': receptionId,
  };
}
