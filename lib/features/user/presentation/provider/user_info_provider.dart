import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/user/data/api/user_api_service.dart';
import 'package:falletter_mobile_v2/features/user/data/model/my_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoApiService = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});

final userInfoProvider = StateNotifierProvider<UserInfoNotifier, AsyncValue<UserInfoModel>>((ref) {
  final apiService = ref.watch(userInfoApiService);
  return UserInfoNotifier(apiService);
});

class UserInfoNotifier extends StateNotifier<AsyncValue<UserInfoModel>> {
  final UserApiService apiService;

  UserInfoNotifier(this.apiService) : super(AsyncLoading()) {
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      final info = await apiService.getUserInfo();
      state = AsyncData(info);
    } catch(e, st) {
      state = AsyncError(e, st);
      throw Exception('내 정보 조회 실패');
    }
  }
}