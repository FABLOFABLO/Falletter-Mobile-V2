import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';

class ReportApiService {
  final Dio dio;

  ReportApiService(this.dio);

  Future<void> reportPost({required int contentId, required String reason}) async {
    try {
      final response = await dio.post(
        '${ApiEndpoints.report}/$contentId',
        data: {
          'reason': reason
        }
      );

      if (response.statusCode == 201) return;
      throw Exception('게시물 신고에 실패했습니다.');
    } catch(e) {
      throw Exception('게시물 신고에 실패했습니다. $e');
    }
  }
}