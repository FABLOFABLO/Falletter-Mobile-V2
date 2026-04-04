class NotificationSettingModel {
  final bool pushEnabled;
  final bool commentEnabled;
  final bool brickActivationEnabled;
  final bool brickEnabled;
  final bool letterEnabled;
  final bool letterSentEnabled;
  final bool adminNoticeEnabled;

  NotificationSettingModel({
    required this.pushEnabled,
    required this.commentEnabled,
    required this.brickActivationEnabled,
    required this.brickEnabled,
    required this.letterEnabled,
    required this.letterSentEnabled,
    required this.adminNoticeEnabled
  });

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingModel(
        pushEnabled: json['pushEnabled'],
        commentEnabled: json['commentEnabled'],
        brickActivationEnabled: json['brickActivationEnabled'],
        brickEnabled: json['brickEnabled'],
        letterEnabled: json['letterEnabled'],
        letterSentEnabled: json['letterSentEnabled'],
        adminNoticeEnabled: json['adminNoticeEnabled']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushEnabled': pushEnabled,
      'commentEnabled': commentEnabled,
      'brickActivationEnabled': brickActivationEnabled,
      'brickEnabled': brickEnabled,
      'letterEnabled': letterEnabled,
      'letterSentEnabled': letterSentEnabled,
      'adminNoticeEnabled': adminNoticeEnabled,
    };
  }

  NotificationSettingModel copyWith({
    bool? pushEnabled,
    bool? commentEnabled,
    bool? brickActivationEnabled,
    bool? brickEnabled,
    bool? letterEnabled,
    bool? letterSentEnabled,
    bool? adminNoticeEnabled,
  }) {
    return NotificationSettingModel(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      commentEnabled: commentEnabled ?? this.commentEnabled,
      brickActivationEnabled:
      brickActivationEnabled ?? this.brickActivationEnabled,
      brickEnabled: brickEnabled ?? this.brickEnabled,
      letterEnabled: letterEnabled ?? this.letterEnabled,
      letterSentEnabled: letterSentEnabled ?? this.letterSentEnabled,
      adminNoticeEnabled:
      adminNoticeEnabled ?? this.adminNoticeEnabled,
    );
  }
}