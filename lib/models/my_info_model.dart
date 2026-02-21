class UserInfoModel {
  final int id;
  final String email;
  final String schoolNumber;
  final String name;
  final String gender;
  final String theme;
  final String profileImage;
  final int attendDay;

  UserInfoModel({
    required this.id,
    required this.email,
    required this.schoolNumber,
    required this.name,
    required this.gender,
    required this.theme,
    required this.profileImage,
    required this.attendDay,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      email: json['email'],
      schoolNumber: json['school_number'],
      name: json['name'],
      gender: json['gender'],
      theme: json['theme'],
      profileImage: json['profile_image'],
      attendDay: json['addend_day'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'schoolNumber': schoolNumber,
    'name': name,
    'gender': gender,
    'theme': theme,
    'profileImage': profileImage,
    'attend_day' : attendDay,
  };
}
