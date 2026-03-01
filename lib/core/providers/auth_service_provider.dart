import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/service/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthService(dio.dio);
});
