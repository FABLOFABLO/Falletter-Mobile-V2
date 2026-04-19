import 'dart:io';
import 'package:falletter_mobile_v2/core/service/fcm_device_api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNoti =
      FlutterLocalNotificationsPlugin();

  static const String _androidChannelId = 'fcm_default_channel';

  Future<void> init() async {
    if (Platform.isAndroid) {
      await Permission.notification.request();
    }

    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    await _initLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((message) async {
      await _showForegroundNotification(message);
    });

    if (Platform.isIOS) {
      await _waitForApnsToken();
    }

    final token = await _retryGetFcmToken();

    if (token != null) {
      final storage = FlutterSecureStorage();
      await storage.write(key: 'fcm_token', value: token);
    }

    _messaging.onTokenRefresh.listen((newToken) async {
      final storage = FlutterSecureStorage();
      await storage.write(key: 'fcm_token', value: newToken);
    });
  }

  Future<void> registerToken(FcmDeviceApiService api) async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'fcm_token');
    if (token == null) return;

    final deviceId = await _getDeviceId();

    try {
      await api.registerToken(token: token, deviceId: deviceId);
    } catch (e) {
      debugPrint('FCM 토큰 등록 실패: $e');
    }
  }

  Future<String> _getDeviceId() async {
    const storage = FlutterSecureStorage();

    String? id = await storage.read(key: 'device_id');

    if (id == null) {
      id = const Uuid().v4();
      await storage.write(key: 'device_id', value: id);
    }

    return id;
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNoti.initialize(initSettings);

    const channel = AndroidNotificationChannel(
      _androidChannelId,
      '기본 알림',
      importance: Importance.high,
    );

    await _localNoti
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      '기본 알림',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNoti.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }

  Future<void> _waitForApnsToken() async {
    for (int i = 0; i < 40; i++) {
      final apnsToken = await _messaging.getAPNSToken();

      if (apnsToken != null) return;

      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception('APNS 토큰 못 받음');
  }

  Future<String?> _retryGetFcmToken() async {
    for (int i = 0; i < 40; i++) {
      final token = await _messaging.getToken();
      if (token != null && token.isNotEmpty) return token;
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }
}
