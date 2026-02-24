import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/notice_models.dart';

class NoticeApiService {
  final Dio _dio;

  NoticeApiService(this._dio);

  Future<List<NoticeItem>> getNoticeList() async {
    try {
      final response = await _dio.get(ApiEndpoints.notice);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data
            : (response.data['notices'] ?? []);
        return data.map((json) => NoticeItem.fromJson(json)).toList();
      }

      throw Exception('Failed to load notices');
    } catch (e) {
      throw Exception('Failed to load notices: $e');
    }
  }

  Future<NoticeDetail> getNoticeDetail(String noticeId) async {
    try {
      final response = await _dio.get('${ApiEndpoints.notice}/$noticeId');

      if (response.statusCode == 200) {
        return NoticeDetail.fromJson(response.data);
      }

      throw Exception('Failed to load notice detail');
    } catch (e) {
      throw Exception('Failed to load notice detail: $e');
    }
  }

  Future<void> unlockHint({
    required String noticeId,
    required int hintIndex,
  }) async {
    try {
      await _dio.patch(
        '${ApiEndpoints.notice}/$noticeId/hint',
        data: {'hint_index': hintIndex},
      );
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? '브릭이 부족합니다';
        throw Exception(message);
      }
      throw Exception('Failed to unlock hint: $e');
    }
  }

  Future<void> markAsRead(String noticeId) async {
    try {
      await _dio.patch('${ApiEndpoints.notice}/$noticeId/read');
    } catch (e) {
      print('Failed to mark notice as read: $e');
    }
  }
}
