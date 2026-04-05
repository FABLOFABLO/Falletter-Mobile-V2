import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/models/suspend_model.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/suspend_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final suspendApiServiceProvider = Provider<SuspendApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return SuspendApiService(dio);
});

final suspendProvider =
    StateNotifierProvider<SuspendNotifier, List<SuspendModel>>((ref) {
      final apiService = ref.read(suspendApiServiceProvider);
      return SuspendNotifier(apiService);
    });

class SuspendNotifier extends StateNotifier<List<SuspendModel>> {
  final SuspendApiService apiService;

  SuspendNotifier(this.apiService) : super([]);

  Future<void> loadSuspend() async {
    try {
      final suspendList = await apiService.getSuspendAll();
      state = suspendList;
    } catch (e) {
      throw Exception('정지/경고 목록 조회에 실패했습니다.');
    }
  }
}
