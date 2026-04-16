import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/user/data/model/student_model.dart';
import 'package:falletter_mobile_v2/features/user/data/model/my_info_model.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/signup_model.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/token_model.dart';

class UserApiService {
  final Dio dio;

  UserApiService(this.dio);

  Future<void> signup(SignupModel request) async {
    try {
      final response = await dio.post(
          ApiEndpoints.signup,
        data: request.toJson()
      );

      if (response.statusCode == 201) return;
      throw Exception('회원가입 실패');
    } catch(e) {
      throw Exception('회원가입 실패');
    }
  }

  Future<TokenModel> signin({required String email, required String password}) async {
    try {
      final response = await dio.post(
        ApiEndpoints.signin,
        data: {
          'email': '$email@dsm.hs.kr',
          'password': password
        }
      );

      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      }
      throw Exception('로그인 실패');
    } catch(e) {
      throw Exception('로그인 실패');
    }
  }

  Future<UserInfoModel> getUserInfo() async {
    try {
      final response = await dio.get(ApiEndpoints.users);
      if (response.statusCode == 200) {
        return UserInfoModel.fromJson(response.data);
      }
      throw Exception('내 정보 조회 실패');
    } catch(e) {
      throw Exception('내 정보 조회 실패: $e');
    }
  }

  Future<List<StudentModel>> getAllStudent() async {
    try {
      final response = await dio.get(ApiEndpoints.student);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => StudentModel.fromJson(json)).toList();
      }
      throw Exception('학생 조회 실패');
    } catch(e) {
      throw Exception('학생 조회 실패');
    }
  }

  Future<void> logout() async {
    try {
      final response = await dio.delete(ApiEndpoints.logout);
      if (response.statusCode == 204) return;
      throw Exception('로그아웃 실패');
    } catch(e) {
      throw Exception('로그아웃 실패');
    }
  }
}