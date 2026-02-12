class LetterModel {
  final String content;
  final int receptionId;

  LetterModel({required this.content, required this.receptionId});

  factory LetterModel.fromJson(Map<String, dynamic> json) {
    return LetterModel(
      content: json['content'],
      receptionId: json['reception_id'] ?? 0,
    );
  }

  Map<String,dynamic> toJson()=>{
    'content':content,
    'reception_id': receptionId,
  };
}
