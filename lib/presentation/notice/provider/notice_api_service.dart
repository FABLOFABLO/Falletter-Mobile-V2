import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/notice_models.dart';

class NoticeApiService {
  final Dio _dio;

  NoticeApiService(this._dio);

  Future<List<NoticeItem>> getNoticeList() async {
    try {
      final response = await _dio.get(ApiEndpoints.chosen);

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

  Future<int> saveHint({
    required int answerId,
    required String firstHint,
    String secondHint = '',
    String thirdHint = '',
  }) async {
    final requestBody = {
      'answerId': answerId,
      'firstHint': firstHint,
      'secondHint': secondHint,
      'thirdHint': thirdHint,
    };
    try {
      final response = await _dio.post(ApiEndpoints.save, data: requestBody);

      int hintId = 0;
      if (response.data != null) {
        if (response.data is Map) {
          hintId = response.data['id'] ?? response.data['hintId'] ?? 0;
        }
      }
      return hintId;
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        if (statusCode == 400) {
          throw Exception(responseData['message'] ?? '잘못된 요청입니다');
        } else if (statusCode == 401) {
          throw Exception('인증이 필요합니다');
        } else if (statusCode == 403) {
          throw Exception('권한이 없습니다');
        } else if (statusCode == 404) {
          throw Exception('답변을 찾을 수 없습니다');
        }
      }
      throw Exception('힌트 저장 실패: $e');
    }
  }

  Future<HintData> getHint({required int answerId}) async {
    final url = '${ApiEndpoints.hint}/$answerId';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return HintData.fromJson(response.data);
      }

      throw Exception('Failed to load hint');
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        if (statusCode == 400) {
          throw Exception(responseData['message'] ?? '잘못된 요청입니다');
        } else if (statusCode == 401) {
          throw Exception('인증이 필요합니다');
        } else if (statusCode == 403) {
          throw Exception('권한이 없습니다');
        } else if (statusCode == 404) {
          throw Exception('힌트를 찾을 수 없습니다');
        }
      }
      throw Exception('힌트 조회 실패: $e');
    }
  }

  Future<void> updateHint({
    required int answerId,
    int? hintId,
    required String firstHint,
    required String secondHint,
    required String thirdHint,
  }) async {
    final requestBody = {
      'answerId': answerId,
      if (hintId != null && hintId > 0) 'hintId': hintId,
      'firstHint': firstHint,
      'secondHint': secondHint,
      'thirdHint': thirdHint,
    };
    try {
      await _dio.patch(ApiEndpoints.update, data: requestBody);
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        if (statusCode == 400) {
          throw Exception(responseData['message'] ?? '잘못된 요청입니다');
        } else if (statusCode == 401) {
          throw Exception('인증이 필요합니다');
        } else if (statusCode == 403) {
          throw Exception('권한이 없습니다');
        } else if (statusCode == 404) {
          throw Exception('힌트를 찾을 수 없습니다');
        }
      }
      throw Exception('힌트 업데이트 실패: $e');
    }
  }

  Future<void> saveBrickHistory({
    required String title,
    required String description,
    required int amount,
    required String type,
    required int questionId,
    required int targetUserId,
    required int writerUserId,
  }) async {
    final requestBody = {
      'title': title,
      'description': description,
      'amount': amount,
      'type': type,
      'questionId': questionId,
      'targetUserId': targetUserId,
      'writerUserId': writerUserId,
    };

    try {
      await _dio.post(
        ApiEndpoints.brickSave,
        data: requestBody,
      );
    } catch (e) {}
  }
}
