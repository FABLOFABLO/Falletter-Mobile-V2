class BrickCountModel {
  final int brickCount;
  final int userId;

  BrickCountModel({required this.brickCount, required this.userId});

  factory BrickCountModel.fromJson(Map<String, dynamic> json) {
    return BrickCountModel(
      brickCount: json['brick_count'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'brick_count': brickCount,
    'user_id': userId,
  };

  BrickCountModel copyWith({int? brickCount, int? userId}) {
    return BrickCountModel(
      brickCount: brickCount ?? this.brickCount,
      userId: userId ?? this.userId,
    );
  }
}

class BrickUpdateModel {
  final int brickUpdate;

  BrickUpdateModel({required this.brickUpdate});

  factory BrickUpdateModel.fromJson(Map<String, dynamic> json) {
    return BrickUpdateModel(brickUpdate: json['brick_update']);
  }

  Map<String, dynamic> toJson() => {'brick_update': brickUpdate};
}
