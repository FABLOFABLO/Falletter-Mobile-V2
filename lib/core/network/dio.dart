import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        onRequest: (options, handler) {
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
