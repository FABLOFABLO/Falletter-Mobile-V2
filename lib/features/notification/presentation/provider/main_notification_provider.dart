import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/notification/data/api/notification_api_service.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/main_notification_model.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/notification_content_model.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/suspend/suspend_model.dart';
import 'package:falletter_mobile_v2/features/notification/data/api/suspend_api_service.dart';
import 'package:falletter_mobile_v2/features/notification/presentation/provider/suspend/suspend_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return NotificationApiService(dio);
});

final mainNotificationProvider =
    StateNotifierProvider<
      MainNotificationNotifier,
      List<MainNotificationModel>
    >((ref) {
      final notificationApi = ref.read(notificationApiServiceProvider);
      final suspendApi = ref.read(suspendApiServiceProvider);

      return MainNotificationNotifier(notificationApi, suspendApi);
    });

class MainNotificationNotifier
    extends StateNotifier<List<MainNotificationModel>> {
  final NotificationApiService notificationApi;
  final SuspendApiService suspendApi;

  MainNotificationNotifier(this.notificationApi, this.suspendApi) : super([]);

  Future<void> loadAll() async {
    try {
      final List<NotificationContentModel> notifications = await notificationApi
          .getNotificationHistory();

      final List<SuspendModel> suspends = await suspendApi.getSuspendAll();

      final filteredNotifications = notifications.where(
        (e) => e.type != 'BLOCK' && e.type != 'WARNING',
      );

      final merge = [
        ...filteredNotifications.map(MainNotificationModel.fromNotification),
        ...suspends.map(MainNotificationModel.fromSuspend),
      ];

      merge.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = merge;
    } catch (e) {
      throw Exception('통합 알림 조회 실패');
    }
  }
}
