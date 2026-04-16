class SuspendModel {
  final int id;
  final String type;
  final int days;
  final DateTime startDate;
  final DateTime endDate;

  SuspendModel({
    required this.id,
    required this.type,
    required this.days,
    required this.startDate,
    required this.endDate,
  });

  factory SuspendModel.fromJson(Map<String, dynamic> json) {
    return SuspendModel(
      id: json['id'],
      type: json['type'],
      days: json['days'],
      startDate: DateTime.parse(json['startDate'] + 'Z').toLocal(),
      endDate: DateTime.parse(json['endDate'] + 'Z').toLocal(),
    );
  }
}
