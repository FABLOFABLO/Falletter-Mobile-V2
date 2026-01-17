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
  final bool? isEnabled;

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
    this.isEnabled,
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
    bool? isEnabled,
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
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignupState> {
  SignUpNotifier() : super(SignupState());

  void setGender(String gender) =>
      state = state.copyWith(gender: gender,isEnabled: true);

  void setSchoolNumber(String number) =>
      state = state.copyWith(schoolNumber: number,isEnabled: true);

  void setEmail(String email) =>
      state = state.copyWith(email: email,isEnabled: true);

  void setPassword(String pw) =>
      state = state.copyWith(password: pw,isEnabled: true);

  void setName(String name) =>
      state = state.copyWith(name: name,isEnabled: true);

  void setPasswordCheck(String check) =>
      state = state.copyWith(passwordCheck: check,isEnabled: true);

  void setVerified(bool verified) =>
      state = state.copyWith(verified: verified,isEnabled: true);

  void setTimer(Duration timer) =>
      state = state.copyWith(timer: timer,isEnabled: true);

  void setHasError(String error) =>
      state = state.copyWith(hasError: error,isEnabled: true);
}
final signUpProvider = StateNotifierProvider<SignUpNotifier, SignupState>((ref) {
  return SignUpNotifier();
});


