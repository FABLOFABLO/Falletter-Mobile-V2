import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/router/app_router.dart';
import 'package:falletter_mobile_v2/core/theme/falletter_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
      ProviderScope(
          child: const MyApp(),
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: FalletterColor.black,
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionTheme,
      ),
    );
  }
}