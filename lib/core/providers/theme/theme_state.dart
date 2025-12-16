import 'package:falletter_mobile_v2/core/constants/app_theme_color.dart';
import 'package:riverpod/riverpod.dart';

final themeProvider = NotifierProvider<ThemeNotifier, AppTheme>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<AppTheme> {
  @override
  AppTheme build() => AppTheme.blue;

  void changeTheme(AppTheme theme) {
    state = theme;
  }
}