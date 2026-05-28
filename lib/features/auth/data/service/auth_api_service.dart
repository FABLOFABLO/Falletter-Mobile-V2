import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/token_model.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService(this.dio);

  Future<TokenModel> getRefreshToken({required String refreshToken}) async {
    try {
      final response = await dio.post(
          ApiEndpoints.refreshToken,
        data: {
            'refreshToken': refreshToken
        }
      );
      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      }
      throw Exception('토큰 재발급 실패');
    } catch(e) {
      throw Exception('토큰 재발급 실패');
    }
  }

  Future<void> sendEmailVerify({required String email}) async {
    try {
      final response = await dio.post(
          ApiEndpoints.emailVerify,
        data: {
            'email': '$email@dsm.hs.kr'
        }
      );
      if (response.statusCode == 200) return;
      throw Exception('이메일 인증코드 발송 실패');
    } catch(e) {
      throw Exception('이메일 인증코드 발송 실패: $e');
    }
  }

  Future<bool> checkVerifyCode({required String email, required String verifyCode}) async {
    try {
      final response = await dio.post(
        ApiEndpoints.emailMatch,
        data: {
          'email': email,
          'verifyCode': verifyCode
        }
      );

      if (response.statusCode == 200) return true;
      else if (response.statusCode == 403) return false;
      else throw Exception('인증코드 확인 실패');
    } catch(e) {
      throw Exception('인증코드 확인 실패');
    }
  }
}