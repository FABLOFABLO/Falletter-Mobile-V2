import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupState {
  final String? gender;
  final String? schoolNumber;
  final String? email;
  final String? password;
  final String? name;
  final String? passwordCheck;
  final bool? verified;
  final Duration? timer;
  final String? hasError;

  SignupState({
    this.gender,
    this.schoolNumber,
    this.email,
    this.password,
    this.name,
    this.passwordCheck,
    this.verified,
    this.timer,
    this.hasError,
  });

  SignupState copyWith({
    String? gender,
    String? schoolNumber,
    String? email,
    String? password,
    String? name,
    String? passwordCheck,
    bool? verified,
    Duration? timer,
    String? hasError,
  }) {
    return SignupState(
      gender: gender ?? this.gender,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      passwordCheck: passwordCheck ?? this.passwordCheck,
      verified: verified ?? this.verified,
      timer: timer ?? this.timer,
      hasError: hasError ?? this.hasError,
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

  void setPasswordCheck(String check) =>
      state = state.copyWith(passwordCheck: check);

  void setVerified(bool verified) =>
      state = state.copyWith(verified: verified);

  void setTimer(Duration timer) =>
      state = state.copyWith(timer: timer);

  void setHasError(String error) =>
      state = state.copyWith(hasError: error);
}
final signUpProvider = StateNotifierProvider<SignUpNotifier, SignupState>((ref) {
  return SignUpNotifier();
});


