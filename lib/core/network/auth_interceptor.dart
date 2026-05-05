import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final VoidCallback onAuthFailed;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    required this.onAuthFailed,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenStorage.readAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 && err.response?.statusCode != 403) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;

    if (requestOptions.extra['retry'] == true) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      try {
        await _refreshCompleter?.future;

        final newAccessToken = await tokenStorage.readAccessToken();

        final newRequest = requestOptions.copyWith(
          extra: {...requestOptions.extra, 'retry': true},
        );
        newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

        final response = await dio.fetch(newRequest);

        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refreshToken = await tokenStorage.readRefreshToken();

      if (refreshToken == null) {
        await tokenStorage.clear();
        onAuthFailed();
        return handler.reject(err);
      }

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {Headers.acceptHeader: Headers.jsonContentType},
        ),
      );

      final response = await refreshDio.post(
        ApiEndpoints.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      await tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      _refreshCompleter?.complete();

      final newRequest = requestOptions.copyWith(
        extra: {...requestOptions.extra, 'retry': true},
      );
      newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

      final retryResponse = await dio.fetch(newRequest);

      return handler.resolve(retryResponse);
    } catch (e) {
      _refreshCompleter?.completeError(e);

      await tokenStorage.clear();
      onAuthFailed();

      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
