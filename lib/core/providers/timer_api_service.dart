import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/timer_model.dart';

class TimerApiService {
  final Dio dio;

  TimerApiService(this.dio);

  Future<TimerModel> getRouletteTimer() async {
    try {
      final response = await dio.get(ApiEndpoints.rouletteTimer);

      if (response.statusCode == 200) {
        return TimerModel.fromJson(response.data);
      }
      throw Exception('Failed to get roulette timer');
    } catch(e) {
      print('Failed to get roulette timer: $e');
      rethrow;
    }
  }

  Future<void> startRouletteTimer() async {
    try {
      final response = await dio.post(ApiEndpoints.rouletteTimer);

      if (response.statusCode == 201) return;
      throw Exception('Failed to start roulette timer');
    } catch(e) {
      throw Exception('Failed to start roulette timer: $e');
    }
  }

  Future<TimerModel> getBrickTimer() async {
    try {
      final response = await dio.get(ApiEndpoints.brickTimer);

      if (response.statusCode == 200) {
        return TimerModel.fromJson(response.data);
      }
      throw Exception('브릭 타이머 조회에 실패');
    } catch(e) {
      throw Exception('브릭 타이머 조회 실패: $e');
    }
  }

  Future<void> startBrickTimer() async {
    try {
      final response = await dio.post(ApiEndpoints.brickTimer);

      if (response.statusCode == 201) return;
      throw Exception('브릭 타이머 시작 실패');
    } catch(e) {
      throw Exception('브릭 타이머 시작 실패: $e');
    }
  }
}