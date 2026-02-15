import 'package:falletter_mobile_v2/core/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInState {
  final bool isValid;

  SignInState({this.isValid = false});

  SignInState copyWith({bool? isValid}) {
    return SignInState(isValid: isValid ?? this.isValid);
  }
}

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(SignInState());

  void enabledButton(String email, String password) {
    final bool emailWrite = emailValid(email.trim());
    final bool passwordWrite = password.isNotEmpty;

    state = state.copyWith(isValid: emailWrite && passwordWrite);
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) => SignInNotifier(),
);
