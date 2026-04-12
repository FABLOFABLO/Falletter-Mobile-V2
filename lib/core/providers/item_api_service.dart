import 'dart:developer' as develop;
import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/brick_count_model.dart';
import 'package:falletter_mobile_v2/models/letter_count_model.dart';

class ItemApiService {
  final Dio dio;

  ItemApiService(this.dio);

  Future<LetterCountModel> getLetterCount() async {
    try {
      final response = await dio.get(ApiEndpoints.letterCount);
      if (response.statusCode == 200) {
        return LetterCountModel.fromJson(response.data);
      }
      throw Exception('편지 수량 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('편지 수량 조회 실패');
    }
  }

  Future<BrickCountModel> getBrickCount() async {
    try {
      final response = await dio.get(ApiEndpoints.brickCount);
      if (response.statusCode == 200) {
        return BrickCountModel.fromJson(response.data);
      }
      throw Exception('브릭 수량 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 수량 조회 실패');
    }
  }

  Future<void> updateLetterCount(int letterUpdate) async {
    try {
      final response = await dio.patch(
          ApiEndpoints.letterUpdate,
          data: {
            'letterUpdate': letterUpdate
          }
      );
      if (response.statusCode == 200) return;
      throw Exception('레터 수량 변경 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('레터 수량 변경 실패');
    }
  }

  Future<void> updateBrickCount(int brickUpdate) async {
    try {
      final response = await dio.patch(
          ApiEndpoints.brickUpdate,
          data: {
            'brickUpdate': brickUpdate
          }
      );
      if (response.statusCode == 200) return;
      throw Exception('브릭 수량 변경 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 수량 변경 실패');
    }
  }
}