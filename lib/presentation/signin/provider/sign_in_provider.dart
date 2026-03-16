import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/providers/user_api_service.dart';
import 'package:falletter_mobile_v2/core/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInState {
  final bool isValid;

  SignInState({this.isValid = false});

  SignInState copyWith({bool? isValid}) {
    return SignInState(isValid: isValid ?? this.isValid);
  }
}

final loginApiServiceProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});

class SignInNotifier extends StateNotifier<SignInState> {
  final UserApiService apiService;
  final TokenStorage tokenStorage;

  SignInNotifier(this.apiService, this.tokenStorage) : super(SignInState());

  void enabledButton(String email, String password) {
    final bool emailWrite = emailValid(email);
    final bool passwordWrite = password.isNotEmpty;

    state = state.copyWith(isValid: emailWrite && passwordWrite);
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final token = await apiService.signin(
          email: email,
          password: password
      );

      await tokenStorage.saveTokens(
          accessToken: token.accessToken,
          refreshToken: token.refreshToken
      );

      return true;
    } catch(e) {
      return false;
    }
  }
}

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>((ref) {
      final apiService = ref.read(loginApiServiceProvider);
      final storage = TokenStorage(FlutterSecureStorage());
      return SignInNotifier(apiService, storage);
    }
);