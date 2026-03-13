import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenStorage = TokenStorage(FlutterSecureStorage());
          final accessToken = await tokenStorage.readAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref: ref);
});
