import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/token_refresher.dart';
import 'package:falletter_mobile_v2/core/network/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final TokenRefresher tokenRefresher;
  final VoidCallback onAuthFailed;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
    required this.tokenRefresher,
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
    final statusCode = err.response?.statusCode;
    if (statusCode != 401 && statusCode != 403) {
      return handler.next(err);
    }

    final requestOptions = err.requestOptions;

    if (requestOptions.extra['retry'] == true) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      try {
        await _refreshCompleter?.future;
      } catch (_) {
        return handler.next(err);
      }
      return _retry(requestOptions, handler, err);
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    bool refreshed;
    try {
      refreshed = await tokenRefresher.refresh();
    } catch (_) {
      refreshed = false;
    }

    if (!refreshed) {
      _refreshCompleter?.completeError(err);
      _isRefreshing = false;
      await tokenStorage.clear();
      onAuthFailed();
      return handler.reject(err);
    }

    _refreshCompleter?.complete();
    _isRefreshing = false;

    return _retry(requestOptions, handler, err);
  }

  Future<void> _retry(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
    DioException err,
  ) async {
    try {
      final newAccessToken = await tokenStorage.readAccessToken();
      final newRequest = requestOptions.copyWith(
        extra: {...requestOptions.extra, 'retry': true},
      );
      newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

      final response = await dio.fetch(newRequest);
      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }
}
