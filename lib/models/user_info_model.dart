class UserInfoModel {
  final int id;
  final String email;
  final String schoolNumber;
  final String name;
  final String gender;
  final String theme;
  final String profileImage;

  UserInfoModel({
    required this.id,
    required this.email,
    required this.schoolNumber,
    required this.name,
    required this.gender,
    required this.theme,
    required this.profileImage
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        id: json['id'],
        email: json['email'],
        schoolNumber: json['schoolNumber'],
        name: json['name'],
        gender: json['gender'],
        theme: json['theme'],
        profileImage: json['profileImage']
    );
  }
}