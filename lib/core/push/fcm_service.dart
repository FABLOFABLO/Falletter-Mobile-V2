import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initAndGetToken() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (kDebugMode) debugPrint('Android Notification Permission: $status');
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        debugPrint('Foreground Message received: ${message.notification?.title}');
      }
      // 여기서 Local Notifications 등을 이용해 팝업을 띄울 수 있슴
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        debugPrint('Message clicked and app opened: ${message.data}');
      }
      // 특정 페이지로 이동하는 로직 등을 구현
    });

    if (Platform.isIOS) {
      await _waitForApnsToken();
    }

    final token = await _retryGetFcmToken();
    if (kDebugMode) debugPrint('FCM token: $token');

    _messaging.onTokenRefresh.listen((newToken) {
      // TODO: 서버 연동 시 업데이트 API 호출
    });
  }

  Future<void> _waitForApnsToken() async {
    for (int i = 0; i < 40; i++) {
      try {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null && apnsToken.isNotEmpty) {
          if (kDebugMode)
            debugPrint('APNs token ready: ${apnsToken.substring(0, 8)}...');
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
        if (token != null && token.isNotEmpty) {
          return token;
        }
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
