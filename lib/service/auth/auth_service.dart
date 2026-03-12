import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/token_model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<TokenModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.signin,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request 잘못된 요청');
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden 권한 없음');
      }else if(response.statusCode == 404){
        throw Exception('Not Found 사용자를 찾을 수 없음');
      }
      else{
        throw Exception('Internal Server Error');
      }
    } on DioException catch (e) {
      throw Exception('다른 오류: ${e.message}');
    }
  }
}