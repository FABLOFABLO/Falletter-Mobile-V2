import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/notification/data/api/notification_api_service.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/notification_content_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return NotificationApiService(dio);
});

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<NotificationContentModel>>(
      (ref) {
        final apiService = ref.read(notificationApiServiceProvider);
        return NotificationNotifier(apiService);
      },
    );

class NotificationNotifier
    extends StateNotifier<List<NotificationContentModel>> {
  final NotificationApiService apiService;

  NotificationNotifier(this.apiService) : super([]);

  Future<void> loadNotifications() async {
    try {
      final notifications = await apiService.getNotificationHistory();
      state = notifications;
    } catch (e) {
      throw Exception('알림 조회에 실패했습니다.');
    }
  }
}
