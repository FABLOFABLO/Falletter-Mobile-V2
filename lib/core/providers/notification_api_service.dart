import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/notification_content_model.dart';
import 'package:falletter_mobile_v2/models/notification_setting_model.dart';

class NotificationApiService {
  final Dio dio;

  NotificationApiService(this.dio);

  Future<NotificationSettingModel> getNotificationSetting() async {
    try {
      final response = await dio.get(ApiEndpoints.notificationSetting);

      if (response.statusCode == 200) {
        return NotificationSettingModel.fromJson(response.data);
      }
      throw Exception('알림 설정 조회 실패');
    } catch (e) {
      throw Exception('알림 설정 조회 실패');
    }
  }

  Future<void> editNotificationSetting(NotificationSettingModel request) async {
    try {
      final response = await dio.patch(
        ApiEndpoints.notificationSetting,
        data: request.toJson(),
      );

      if (response.statusCode == 204) return;
      throw Exception('알림 설정 수정 실패');
    } catch (e) {
      throw Exception('알림 설정 수정 실패');
    }
  }

  Future<List<NotificationContentModel>> getNotificationHistory() async {
    try {
      final response = await dio.get(ApiEndpoints.notificationHistory);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['content'] ?? [];
        return data
            .map((json) => NotificationContentModel.fromJson(json))
            .toList();
      }
      throw Exception('알림 조회 실패');
    } catch (e) {
      throw Exception('알림 조회 실패');
    }
  }
}
