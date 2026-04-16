import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  logIn,
  notLogIn,
}

final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  await Future.delayed(const Duration(seconds: 1));

  /// TODO: secure storage / prefs 에서 토큰 확인
  final hasToken = false;

  if(hasToken) {
    return AuthStatus.logIn;
  } else {
    return AuthStatus.notLogIn;
  }
});