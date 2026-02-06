import 'dart:async';

import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/router/app_router.dart';
import 'package:falletter_mobile_v2/core/theme/falletter_theme.dart';
import 'package:falletter_mobile_v2/core/push/fcm_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin _localNoti =
FlutterLocalNotificationsPlugin();

Future<void> _setupAndroidNotificationChannel() async {
  const channel = AndroidNotificationChannel(
    'fcm_default_channel',
    '기본 알림',
    description: 'FCM 기본 알림 채널',
    importance: Importance.high,
  );

  final androidPlugin = _localNoti.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  await androidPlugin?.createNotificationChannel(channel);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setupAndroidNotificationChannel();

  runApp(const ProviderScope(child: MyApp()));

  unawaited(FcmService.instance.initAndGetToken());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: FalletterColor.black,
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionTheme,
      ),
    );
  }
}