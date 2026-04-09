class SuspendReasonModel {
  final int id;
  final String reason;

  SuspendReasonModel({required this.id, required this.reason});

  factory SuspendReasonModel.fromJson(Map<String, dynamic> json) {
    return SuspendReasonModel(
        id: json['id'],
        reason: json['reason']
    );
  }
}
