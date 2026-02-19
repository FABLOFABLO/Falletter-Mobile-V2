class MyInfoModel {
  final int id;
  final String email;
  final String schoolNumber;
  final String name;
  final String gender;
  final String theme;
  final String profileImage;

  MyInfoModel({
    required this.id,
    required this.email,
    required this.schoolNumber,
    required this.name,
    required this.gender,
    required this.theme,
    required this.profileImage,
  });

  factory MyInfoModel.fromJson(Map<String, dynamic> json) {
    return MyInfoModel(
      id: json['id'],
      email: json['email'],
      schoolNumber: json['school_number'],
      name: json['name'],
      gender: json['gender'],
      theme: json['theme'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson()=>{
      'id' : id,
    'email' : email,
    'school_number' : schoolNumber,
    'name' : name,
    'gender' : gender,
    'theme' : theme,
    'profile_image' : profileImage,
  };
}
