import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/notification_api_service.dart';
import 'package:falletter_mobile_v2/models/notification_setting_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NotificationSettingType {
  push,
  comment,
  brickActivation,
  brick,
  letter,
  letterSent,
  adminNotice,
}

final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return NotificationApiService(dio);
});

final notificationSettingProvider =
    StateNotifierProvider<
      NotificationSettingNotifier,
      NotificationSettingModel?
    >((ref) {
      final apiService = ref.read(notificationApiServiceProvider);
      return NotificationSettingNotifier(apiService);
    });

class NotificationSettingNotifier
    extends StateNotifier<NotificationSettingModel?> {
  final NotificationApiService apiService;

  NotificationSettingNotifier(this.apiService) : super(null);

  Future<void> loadSetting() async {
    try {
      final setting = await apiService.getNotificationSetting();
      state = setting;
    } catch (e) {
      throw Exception('알림 설정 조회에 실패했습니다. $e');
    }
  }

  void toggle(NotificationSettingType type, bool value) {
    if (state == null) return;

    switch(type) {
      case NotificationSettingType.push:
        state = state!.copyWith(pushEnabled: value);
        break;
      case NotificationSettingType.comment:
        state = state!.copyWith(commentEnabled: value);
        break;
      case NotificationSettingType.brickActivation:
        state = state!.copyWith(brickActivationEnabled: value);
        break;
      case NotificationSettingType.brick:
        state = state!.copyWith(brickEnabled: value);
        break;
      case NotificationSettingType.letter:
        state = state!.copyWith(letterEnabled: value);
        break;
      case NotificationSettingType.letterSent:
        state = state!.copyWith(letterSentEnabled: value);
        break;
      case NotificationSettingType.adminNotice:
        state = state!.copyWith(adminNoticeEnabled: value);
        break;
    }
  }

  Future<void> editSetting() async {
    if (state == null) return;
    try {
      await apiService.editNotificationSetting(state!);
      loadSetting();
    } catch (e) {
      throw Exception('알림 설정에 실패했습니다. $e');
    }
  }
}
