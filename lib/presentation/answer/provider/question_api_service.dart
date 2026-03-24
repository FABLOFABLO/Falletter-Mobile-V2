import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/question_model.dart';

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
      throw Exception('질문 조회 실패: $e');
    }
  }
}