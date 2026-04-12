import 'dart:developer' as develop;

import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';

class AnswerApiService {
  final Dio dio;

  AnswerApiService(this.dio);

  Future<void> chooseAnswer(int questionId, int targetUser) async {
    try {
      final response = await dio.post(
        ApiEndpoints.choose,
        data: {
          'questionId': questionId,
          'targetUser': targetUser
        }
      );
      if (response.statusCode == 201) return;
    } catch(e) {
      develop.log('error: $e');
      throw Exception('답변 저장 실패');
    }
  }
}