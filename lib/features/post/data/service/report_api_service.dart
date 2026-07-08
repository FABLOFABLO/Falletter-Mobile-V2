import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';

class ReportApiService {
  final Dio dio;

  ReportApiService(this.dio);

  Future<void> reportPost({required int contentId, required String reason}) async {
    await dio.post(
      '${ApiEndpoints.report}/$contentId',
      data: {
        'reason': reason
      }
    );
  }
}