import 'package:falletter_mobile_v2/features/notification/data/model/notification_content_model.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/suspend/suspend_model.dart';

class MainNotificationModel {
  final int notificationId;
  final int? suspendId;
  final String type;
  final String title;
  final String body;
  final String? imageUrl;
  final int? relatedId;
  final DateTime createdAt;
  final DateTime? expiredAt;
  final int? days;

  MainNotificationModel({
    required this.notificationId,
    this.suspendId,
    required this.type,
    required this.title,
    required this.body,
    this.imageUrl,
    this.relatedId,
    required this.createdAt,
    this.expiredAt,
    this.days,
  });

  factory MainNotificationModel.fromNotification(NotificationContentModel e) {
    return MainNotificationModel(
      notificationId: e.id,
      suspendId: null,
      type: e.type,
      title: e.title,
      body: e.body,
      imageUrl: e.imageUrl,
      relatedId: e.relatedId,
      createdAt: e.createdAt,
      expiredAt: e.expiredAt,
      days: null,
    );
  }

  factory MainNotificationModel.fromSuspend(SuspendModel e) {
    return MainNotificationModel(
      notificationId: 0,
      suspendId: e.id,
      type: e.type,
      title: e.type == 'BLOCK' ? '계정 이용 일시 정지 안내' : '정책 위반 행위 경고 안내',
      body: '',
      imageUrl: null,
      relatedId: null,
      createdAt: e.startDate,
      expiredAt: e.endDate,
      days: e.days,
    );
  }
}
