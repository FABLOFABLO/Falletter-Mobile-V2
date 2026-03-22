import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/network/auth_intercepter.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';
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
    dio.interceptors.add(
      AuthIntercepter(
          dio: dio,
          tokenStorage: tokenStorage,
          refreshTokenEndpoint: ApiEndpoints.refreshToken
      )
    );
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref: ref);
});
