class RouletteTimerModel {
  final int userId;
  final int remainingSeconds;
  final bool isActive;

  RouletteTimerModel({
    required this.userId,
    required this.remainingSeconds,
    required this.isActive
  });
}