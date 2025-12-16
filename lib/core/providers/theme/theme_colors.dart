import 'package:falletter_mobile_v2/core/constants/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:riverpod/riverpod.dart';

final themeColorsProvider = Provider<ThemeColors>((ref) {
  final theme = ref.watch(themeProvider);
  return appThemeColors[theme]!;
});