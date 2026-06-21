import 'dart:async';
import 'package:falletter_mobile_v2/core/providers/theme/theme_mode_provoder.dart';
import 'package:falletter_mobile_v2/core/router/app_router.dart';
import 'package:falletter_mobile_v2/core/theme/falletter_theme.dart';
import 'package:falletter_mobile_v2/core/theme/theme_mode.dart';
import 'package:falletter_mobile_v2/core/fcm/fcm_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/fcm/firebase_options.dart';

final FlutterLocalNotificationsPlugin _localNoti =
    FlutterLocalNotificationsPlugin();

Future<void> _setupAndroidNotificationChannel() async {
  const channel = AndroidNotificationChannel(
    'fcm_default_channel',
    '기본 알림',
    description: 'FCM 기본 알림 채널',
    importance: Importance.high,
  );

  final androidPlugin = _localNoti
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  await androidPlugin?.createNotificationChannel(channel);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await _setupAndroidNotificationChannel();
  } catch (e) {
    debugPrint('Firebase 초기화 실패: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FcmService.instance.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: themeMode,
      theme: lightTheme.copyWith(textSelectionTheme: textSelectionTheme),
      darkTheme: darkTheme.copyWith(
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionTheme,
      ),
    );
  }
}