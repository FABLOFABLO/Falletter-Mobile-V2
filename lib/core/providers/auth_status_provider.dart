import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/utils/jwt_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthStatus { logIn, notLogIn }

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
});

final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final refresh = await storage.readRefreshToken();

  if (refresh == null || refresh.isEmpty) return AuthStatus.notLogIn;

  if (JwtUtils.isExpired(refresh)) {
    await storage.clear();
    return AuthStatus.notLogIn;
  }

  return AuthStatus.logIn;
});
