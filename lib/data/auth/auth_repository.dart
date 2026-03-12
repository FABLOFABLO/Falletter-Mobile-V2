import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/providers/auth_service_provider.dart';
import 'package:falletter_mobile_v2/core/providers/auth_status_provider.dart';
import 'package:falletter_mobile_v2/models/token_model.dart';
import 'package:falletter_mobile_v2/service/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final AuthService _authService;
  final TokenStorage _tokenStorage;

  AuthRepository(this._authService, this._tokenStorage);

  Future<TokenModel> signIn({
    required String email,
    required String password,
  }) async {
    final signIn = await _authService.signIn(email: email, password: password);
    if (signIn.accessToken != null && signIn.refreshToken != null) {
        await _tokenStorage.saveTokens(
          accessToken: signIn.accessToken!,
          refreshToken: signIn.refreshToken!,
        );
    }
    return signIn;
  }
}


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  final storage = ref.watch(tokenStorageProvider);
  return AuthRepository(service, storage);
});
