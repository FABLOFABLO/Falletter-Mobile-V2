class StudentModel {
  final int id;
  final String schoolNumber;
  final String name;

  StudentModel({
    required this.id,
    required this.schoolNumber,
    required this.name,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? 0,
      schoolNumber: json['schoolNumber'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'schoolNumber': schoolNumber,
    'name': name,
  };
}
