import 'dart:developer' as develop;
import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/answer/data/model/progress_model.dart';

class AnswerApiService {
  final Dio dio;

  AnswerApiService(this.dio);

  Future<void> chooseAnswer(int questionId, int targetUser) async {
    try {
      final response = await dio.post(
        ApiEndpoints.choose,
        data: {'questionId': questionId, 'targetUser': targetUser},
      );
      if (response.statusCode == 201) return;
    } catch (e) {
      develop.log('error: $e');
      throw Exception('답변 저장 실패');
    }
  }

  Future<ProgressModel> createProgress() async {
    try {
      final response = await dio.post(ApiEndpoints.progress);
      if (response.statusCode == 201) {
        return ProgressModel.fromJson(response.data);
      }
      throw Exception('진행 상태 생성 실패');
    } catch (e) {
      develop.log('create error: $e');
      throw Exception('진행 상태 생성 실패');
    }
  }

  Future<void> completeProgress() async {
    try {
      final response = await dio.patch(ApiEndpoints.complete);
      if (response.statusCode == 204) return;
    } catch (e) {
      develop.log('complete error: $e');
      throw Exception('진행 상태 완료 실패');
    }
  }

  Future<ProgressModel> getProgress() async {
    try {
      final response = await dio.get(ApiEndpoints.progress);
      if (response.statusCode == 200) {
        return ProgressModel.fromJson(response.data);
      }
      throw Exception('진행 상태 조회 실패');
    } catch (e) {
      develop.log('get error: $e');
      rethrow;
    }
  }

  Future<ProgressModel> skipProgress() async {
    try {
      final response = await dio.patch(ApiEndpoints.skip);
      if (response.statusCode == 200) {
        return ProgressModel.fromJson(response.data);
      }
      throw Exception('질문 건너뛰기 실패');
    } catch(e) {
      develop.log('skip error: $e');
      throw Exception('질문 건너뛰기 실패');
    }
  }
}
