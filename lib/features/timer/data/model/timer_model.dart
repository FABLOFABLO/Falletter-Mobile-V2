class TimerModel {
  final int userId;
  final int remainingSeconds;
  final bool isActive;

  TimerModel({
    required this.userId,
    required this.remainingSeconds,
    required this.isActive
  });

  factory TimerModel.fromJson(Map<String, dynamic> json) {
    return TimerModel(
        userId: json['userId'] ?? 0,
        remainingSeconds: json['remainingSeconds'] ?? 0,
        isActive: json['isActive'] ?? false
    );
  }
}