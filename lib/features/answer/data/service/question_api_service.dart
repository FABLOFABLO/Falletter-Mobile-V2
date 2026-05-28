import 'dart:developer' as develop;

import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/answer/data/model/question_model.dart';
class QuestionApiService {
  final Dio dio;

  QuestionApiService(this.dio);

  Future<List<QuestionModel>> getQuestionList() async {
    try {
      final response = await dio.get(ApiEndpoints.all);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => QuestionModel.fromJson(json)).toList();
      }
      throw Exception('질문 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('질문 조회 실패');
    }
  }
}