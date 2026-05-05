class ProgressModel {
  final int progressId;
  final int currentIndex;
  final List<int> questionIds;
  final bool isCompleted;

  ProgressModel({
    required this.progressId,
    required this.currentIndex,
    required this.questionIds,
    required this.isCompleted,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      progressId: json['progressId'],
      currentIndex: json['currentIndex'],
      questionIds: List<int>.from(json['questionIds']),
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'progressId': progressId,
      'currentIndex': currentIndex,
      'questionIds': questionIds,
      'isCompleted': isCompleted,
    };
  }
}