import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/user_api_service.dart';
import 'package:falletter_mobile_v2/models/my_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoApiService = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});

final userInfoProvider = FutureProvider<UserInfoModel>((ref) async {
  final apiService = ref.read(userInfoApiService);
  return await apiService.getUserInfo();
});