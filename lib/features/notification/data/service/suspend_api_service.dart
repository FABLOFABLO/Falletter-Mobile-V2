import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/suspend/suspend_model.dart';
import 'package:falletter_mobile_v2/features/notification/data/model/suspend/suspend_reason_model.dart';

class SuspendApiService {
  final Dio dio;

  SuspendApiService(this.dio);

  Future<SuspendReasonModel> getSuspendReason(int suspendId) async {
    try {
      final response = await dio.get('${ApiEndpoints.suspend}/$suspendId');

      if (response.statusCode == 200) {
        return SuspendReasonModel.fromJson(response.data);
      }
      throw Exception('정지 사유 조회 실패');
    } catch(e) {
      throw Exception('정지 사유 조회 실패');
    }
  }

  Future<List<SuspendModel>> getSuspendAll() async {
    try {
      final response = await dio.get(ApiEndpoints.suspendAll);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => SuspendModel.fromJson(json)).toList();
      }
      throw Exception('경고/정지 내역 조회 실패');
    } catch(e) {
      throw Exception('경고/정지 내역 조회 실패');
    }
  }
}