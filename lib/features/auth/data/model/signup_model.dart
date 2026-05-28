class SignupModel {
  final String email;
  final String password;
  final String schoolNumber;
  final String name;
  final String gender;
  final String theme;
  final String profileImage;
  final bool serviceTerms;
  final bool privacyPolicy;
  final bool communityTerms;
  final bool pushNotification;

  SignupModel({
    required this.email,
    required this.password,
    required this.schoolNumber,
    required this.name,
    required this.gender,
    required this.theme,
    required this.profileImage,
    required this.serviceTerms,
    required this.privacyPolicy,
    required this.communityTerms,
    required this.pushNotification
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'schoolNumber': schoolNumber,
      'name': name,
      'gender': gender,
      'theme': theme,
      'profileImage': profileImage,
      'serviceTerms': serviceTerms,
      'privacyPolicy': privacyPolicy,
      'communityTerms': communityTerms,
      'pushNotification': pushNotification
    };
  }
}