import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/student_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeChangeProvider = StateNotifierProvider<ThemeChangeNotifier, AsyncValue<void>>(
      (ref) => ThemeChangeNotifier(ref),
);

class ThemeChangeNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ThemeChangeNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> updateTheme(AppTheme theme) async {
    state = const AsyncValue.loading();

    try {
      await ref.read(userApiService).patchTheme(theme.name.toUpperCase());
      ref.read(themeProvider.notifier).changeTheme(theme);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}