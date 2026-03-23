import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/network/auth_interceptor.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
import 'package:falletter_mobile_v2/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio dio;

  DioClient({required Ref ref})
      : dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {Headers.acceptHeader: Headers.jsonContentType},
    ),
  ) {
    final tokenStorage = TokenStorage(FlutterSecureStorage());
    final router = ref.read(goRouterProvider);
    dio.interceptors.add(
      AuthInterceptor(
          dio: dio,
          tokenStorage: tokenStorage,
          refreshTokenEndpoint: ApiEndpoints.refreshToken,
          onAuthFailed: () {
            router.go('/splash');
          }
      )
    );
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref: ref);
});
