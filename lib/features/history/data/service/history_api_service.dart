import 'dart:developer' as develop;
import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/history/data/model/brick_use_check_model.dart';

class HistoryApiService {
  final Dio dio;

  HistoryApiService(this.dio);

  Future<void> postBrickSave(SaveBrickModel request) async {
    try {
      final response = await dio.post(
          ApiEndpoints.brickSave,
        data: request.toJson(),
      );

      if (response.statusCode == 201) return;
      throw Exception('브릭 사용 기록 저장 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 사용 기록 저장 실패');
    }
  }

  Future<List<BrickUseCheckModel>> getBrickUsed() async {
    try {
      final response = await dio.get(ApiEndpoints.brickUsed);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => BrickUseCheckModel.fromJson(json)).toList();
      }
      throw Exception('브릭 사용 기록 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 사용 기록 조회 실패');
    }
  }
}