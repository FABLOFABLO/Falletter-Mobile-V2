import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/token_model.dart';

class TokenRefresher {
  final TokenStorage tokenStorage;

  TokenRefresher(this.tokenStorage);

  Future<bool> refresh() async {
    final refreshToken = await tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {Headers.acceptHeader: Headers.jsonContentType},
      ),
    );

    try {
      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final tokens = TokenModel.fromJson(response.data);
      await tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      return true;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        await tokenStorage.clear();
      }
      return false;
    }
  }
}
