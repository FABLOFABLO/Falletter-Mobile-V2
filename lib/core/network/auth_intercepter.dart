import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';

class AuthIntercepter extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final String refreshTokenEndpoint;

  AuthIntercepter({
    required this.dio,
    required this.tokenStorage,
    required this.refreshTokenEndpoint
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenStorage.readAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await tokenStorage.readRefreshToken();

        if (refreshToken == null) {
          return handler.next(err);
        }
        
        final response = await dio.post(
            ApiEndpoints.refreshToken,
          data: {
              "refreshToken": refreshToken
          }
        );

        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        await tokenStorage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken
        );

        final options = err.requestOptions;

        options.headers['Authorization'] = 'Berear: $newAccessToken}';

        final retryResponse = await dio.fetch(options);

        return handler.resolve(retryResponse);
      } catch(e) {
        await tokenStorage.clear();
      }
    }
    handler.next(err);
  }
}