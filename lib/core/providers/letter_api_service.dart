import 'dart:developer' as develop;
import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/get_letter_model.dart';
import 'package:falletter_mobile_v2/models/letter_model.dart';
import 'package:falletter_mobile_v2/models/send_letter_model.dart';

class LetterApiService {
  final Dio dio;

  LetterApiService(this.dio);

  Future<void> postLetter(LetterModel request) async {
    try {
      final response = await dio.post(
          ApiEndpoints.sent,
        data: request.toJson()
      );

      if (response.statusCode == 201) return;
      throw Exception('편지 발송 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('편지 발송 실패');
    }
  }

  Future<List<SendLetterModel>> getSendLetterAll() async {
    try {
      final response = await dio.get(ApiEndpoints.sentAll);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => SendLetterModel.fromJson(json)).toList();
      }
      throw Exception('보낸 편지 목록 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('보낸 편지 목록 조회 실패');
    }
  }

  Future<SendLetterModel> getSendLetterDetail(int letterId) async {
    try {
      final response = await dio.get('${ApiEndpoints.sent}/$letterId');

      if (response.statusCode == 200) {
        return SendLetterModel.fromJson(response.data);
      }
      throw Exception('보낸 편지 상세 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('보낸 편지 상세 조회 실패');
    }
  }

  Future<List<GetLetterModel>> getLetterAll() async {
    try {
      final response = await dio.get(ApiEndpoints.receivedAll);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => GetLetterModel.fromJson(json)).toList();
      }
      throw Exception('받은 레터 목록 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('받은 레터 목록 조회 실패');
    }
  }

  Future<GetLetterModel> getLetterDetail(int letterId) async {
    try {
      final response = await dio.get('${ApiEndpoints.received}/$letterId');

      if (response.statusCode == 200) {
        return GetLetterModel.fromJson(response.data);
      }
      throw Exception('받은 레터 상세 조회 실패');
    } catch(e) {
      develop.log('error: $e');
      throw Exception('받은 레터 상세 조회 실패');
    }
  }
}