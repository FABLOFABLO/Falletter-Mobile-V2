class BrickCountModel {
  final int userId;
  final int brickCount;

  BrickCountModel({required this.userId, required this.brickCount});

  factory BrickCountModel.fromJson(Map<String, dynamic> json) {
    return BrickCountModel(
      userId: json['userId'],
      brickCount: json['brickCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'brickCount': brickCount,
  };

  BrickCountModel copyWith({int? brickCount, int? userId}) {
    return BrickCountModel(
      brickCount: brickCount ?? this.brickCount,
      userId: userId ?? this.userId,
    );
  }
}
