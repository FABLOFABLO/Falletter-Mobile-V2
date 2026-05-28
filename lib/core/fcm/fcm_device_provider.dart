import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/service/fcm_device_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmDeviceApiServiceProvider = Provider<FcmDeviceApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return FcmDeviceApiService(dio);
});
