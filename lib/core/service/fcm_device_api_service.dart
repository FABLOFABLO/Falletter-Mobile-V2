import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/core/fcm/fcm_token_model.dart';

class FcmDeviceApiService {
  final Dio dio;

  FcmDeviceApiService(this.dio);

  Future<FcmTokenModel> registerToken({
    required String token,
    required String deviceId,
  }) async {
    final response = await dio.post(
      ApiEndpoints.fcmToken,
      data: {'token': token, 'deviceId': deviceId},
    );

    return FcmTokenModel.fromJson(response.data);
  }

  Future<void> deleteToken(String deviceId) async {
    final response = await dio.delete('/device/token/$deviceId');
    if (response.statusCode == 204) return;
  }
}
