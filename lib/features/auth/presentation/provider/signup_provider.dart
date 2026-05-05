import 'dart:async';
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/auth/data/service/auth_api_service.dart';
import 'package:falletter_mobile_v2/features/user/data/service/user_api_service.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/signup_model.dart';
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
  final bool isLoading;

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
    this.isLoading = false,
  });

  bool emailValid() {
    final input = email ?? '';
    final isValid = RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(input);
    return isValid && input.length >= 4;
  }

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
    bool? isLoading,
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
      hasError: hasError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignupState> {
  final AuthApiService authApiService;
  final UserApiService userApiService;

  SignUpNotifier(
      this.authApiService,
      this.userApiService,
      ) : super(SignupState());

  Timer? timer;

  void startTimer() {
    int limitTime = 300;
    timer?.cancel();

    state = state.copyWith(timer: Duration(seconds: limitTime));

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (limitTime > 0) {
        limitTime--;
        state = state.copyWith(timer: Duration(seconds: limitTime));
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

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

  Future<bool> signup(SignupModel request) async {
    try {
      await userApiService.signup(request);
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> sendEmailCode() async {
    if (state.isLoading) return false;

    try {
      state = state.copyWith(isLoading: true, hasError: null);

      final email = state.email;
      if (email == null) throw Exception();

      await authApiService.sendEmailVerify(email: email);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: '이미 가입된 이메일입니다.',
      );
      return false;
    }
  }

  Future<bool> checkVerifyCode(String verifyCode) async {
    try {
      final email = state.email;
      if (email == null) return false;

      await authApiService.checkVerifyCode(
        email: '$email@dsm.hs.kr',
        verifyCode: verifyCode,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}

final signUpProvider =
StateNotifierProvider<SignUpNotifier, SignupState>((ref) {
  final authApiService = ref.read(authApiServiceProvider);
  final userApiService = ref.read(userApiServiceProvider);
  return SignUpNotifier(authApiService, userApiService);
});

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return AuthApiService(dio);
});

final userApiServiceProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});