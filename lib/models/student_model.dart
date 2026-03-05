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
      id: json['id'],
      schoolNumber: json['school_number'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'school_number': schoolNumber,
    'name': name,
  };
}
