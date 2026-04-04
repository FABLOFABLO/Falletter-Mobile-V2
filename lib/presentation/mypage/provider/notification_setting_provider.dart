import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/notification_api_service.dart';
import 'package:falletter_mobile_v2/models/notification_setting_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return NotificationApiService(dio);
});

final notificationSettingProvider = StateNotifierProvider<NotificationSettingNotifier, NotificationSettingModel?>((ref) {
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

  void togglePush(bool value) {
    if (state == null) return;
    state = state!.copyWith(pushEnabled: value);
  }

  void toggleComment(bool value) {
    if (state == null) return;
    state = state!.copyWith(commentEnabled: value);
  }

  void toggleBrickActivation(bool value) {
    if (state == null) return;
    state = state!.copyWith(brickActivationEnabled: value);
  }

  void toggleBrick(bool value) {
    if (state == null) return;
    state = state!.copyWith(brickEnabled: value);
  }

  void toggleLetter(bool value) {
    if (state == null) return;
    state = state!.copyWith(letterEnabled: value);
  }

  void toggleLetterSent(bool value) {
    if (state == null) return;
    state = state!.copyWith(letterSentEnabled: value);
  }

  void toggleAdminNotice(bool value) {
    if (state == null) return;
    state = state!.copyWith(adminNoticeEnabled: value);
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
