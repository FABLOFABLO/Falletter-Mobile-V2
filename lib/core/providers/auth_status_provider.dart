import 'package:falletter_mobile_v2/core/network/token_refresher.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/utils/jwt_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthStatus { logIn, notLogIn }

extension AppThemeParser on AppTheme {
  static AppTheme fromString(String theme) {
    switch (theme.toUpperCase()) {
      case 'BLUE':
        return AppTheme.blue;
      case 'PINK':
        return AppTheme.pink;
      case 'PURPLE':
        return AppTheme.purple;
      default:
        return AppTheme.blue;
    }
  }
}

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
});

final tokenRefresherProvider = Provider<TokenRefresher>((ref) {
  return TokenRefresher(ref.watch(tokenStorageProvider));
});

final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  final storage = ref.read(tokenStorageProvider);
  final refresh = await storage.readRefreshToken();

  if (refresh == null || refresh.isEmpty) return AuthStatus.notLogIn;

  return AuthStatus.logIn;
});

final appInitProvider = FutureProvider<void>((ref) async {
  final storage = ref.read(tokenStorageProvider);
  final status = await ref.watch(authStatusProvider.future);

  if (status == AuthStatus.notLogIn) return;

  final access = await storage.readAccessToken();

  if (access == null || JwtUtils.isExpired(access)) {
    await ref.read(tokenRefresherProvider).refresh();
  }
});
