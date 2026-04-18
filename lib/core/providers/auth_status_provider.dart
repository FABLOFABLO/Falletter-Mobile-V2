import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/utils/jwt_utils.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/signup_provider.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/student_provider.dart';
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

final authStatusProvider = FutureProvider<AuthStatus>((ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final refresh = await storage.readRefreshToken();

  if (refresh == null || refresh.isEmpty) return AuthStatus.notLogIn;

  try {
    final access = await storage.readAccessToken();
    if (access == null || JwtUtils.isExpired(access)) {
      await ref.read(authApiServiceProvider).getRefreshToken(refreshToken: refresh);
    }
    final user = await ref.read(userApiService).getUserInfo();
    final theme = AppThemeParser.fromString(user.theme);
    ref.read(themeProvider.notifier).changeTheme(theme);
    return AuthStatus.logIn;
  } catch(e) {
    if (e is DioException) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        await storage.clear();
        return AuthStatus.notLogIn;
      }
    }

    return AuthStatus.logIn;
  }
});
