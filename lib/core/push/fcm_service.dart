import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint("Handling a background message: ${message.messageId}");
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNoti =
  FlutterLocalNotificationsPlugin();

  static const String _androidChannelId = 'fcm_default_channel';

  Future<void> initAndGetToken() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (kDebugMode) debugPrint('Android Notification Permission: $status');
    }

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _initLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        debugPrint('Foreground Message received: ${message.notification?.title}');
        debugPrint('Foreground data: ${message.data}');
      }

      await _showForegroundNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        debugPrint('Message clicked and app opened: ${message.data}');
      }
      // TODO: message.data 기반으로 특정 페이지 이동 구현
    });

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      if (kDebugMode) debugPrint('Initial message: ${initial.data}');
      // TODO: initial.data 기반으로 특정 페이지 이동 구현
    }

    if (Platform.isIOS) {
      await _waitForApnsToken();
    }

    final token = await _retryGetFcmToken();
    if (kDebugMode) debugPrint('FCM token: $token');

    _messaging.onTokenRefresh.listen((newToken) {
      // TODO: 서버 연동 시 업데이트 API 호출
      if (kDebugMode) debugPrint('FCM token refreshed: $newToken');
    });
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    final iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNoti.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (kDebugMode) debugPrint('Local noti clicked payload: ${response.payload}');
      },
    );
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final title = message.notification?.title ?? '알림';
    final body = message.notification?.body ?? '';

    final payload = message.data.isNotEmpty ? message.data.toString() : null;

    const androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      '기본 알림',
      channelDescription: 'FCM 기본 알림 채널',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNoti.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> _waitForApnsToken() async {
    for (int i = 0; i < 40; i++) {
      try {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null && apnsToken.isNotEmpty) {
          if (kDebugMode) {
            debugPrint('APNs token ready: ${apnsToken.substring(0, 8)}...');
          }
          return;
        }
      } catch (e) {
        if (kDebugMode) debugPrint('getAPNSToken retry error: $e');
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (kDebugMode) debugPrint('APNs token not ready yet (continuing)');
  }

  Future<String?> _retryGetFcmToken() async {
    bool printedApnsNotSet = false;

    for (int i = 0; i < 40; i++) {
      try {
        final token = await _messaging.getToken();
        if (token != null && token.isNotEmpty) return token;
      } catch (e) {
        final msg = e.toString();
        if (msg.contains('apns-token-not-set')) {
          if (!printedApnsNotSet && kDebugMode) {
            debugPrint('APNs not ready yet (will retry silently)');
            printedApnsNotSet = true;
          }
        } else {
          if (kDebugMode) debugPrint('getToken retry error: $e');
        }
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }
}