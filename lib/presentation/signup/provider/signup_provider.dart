import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupState {
  final String? gender;
  final String? schoolNumber;
  final String? email;
  final String? password;
  final String? name;
  final String? theme;
  final String? profileImage;

  SignupState({
    this.gender,
    this.schoolNumber,
    this.email,
    this.password,
    this.name,
    this.theme,
    this.profileImage,
  });

  SignupState copyWith({
    String? gender,
    String? schoolNumber,
    String? email,
    String? password,
    String? name,
    String? theme,
    String? profileImage
  }) {
    return SignupState(
      gender: gender ?? this.gender,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      theme: theme ?? this.theme,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignupState> {
  SignUpNotifier() : super(SignupState());

  void setGender(String gender) =>
      state = state.copyWith(gender: gender);

  void setSchoolNumber(String number) =>
      state = state.copyWith(schoolNumber: number);

  void setEmail(String email) =>
      state = state.copyWith(email: email);

  void setPassword(String pw) =>
      state = state.copyWith(password: pw);

  void setName(String name) =>
      state = state.copyWith(name: name);

  void setTheme(String theme) =>
      state = state.copyWith(theme: theme);

  void setImageProfile(String profileImage) =>
      state = state.copyWith(profileImage: profileImage);
}

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignupState>((ref) {
  return SignUpNotifier();
});