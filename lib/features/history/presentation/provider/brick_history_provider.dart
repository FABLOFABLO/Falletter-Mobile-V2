import 'dart:developer' as develop;
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/history/data/api/history_api_service.dart';
import 'package:falletter_mobile_v2/features/history/data/model/brick_use_check_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyApiServiceProvider = Provider<HistoryApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return HistoryApiService(dio);
});

final brickHistoryProvider =
StateNotifierProvider<BrickHistoryNotifier, List<BrickUseCheckModel>>((ref) {
  final apiService = ref.read(historyApiServiceProvider);
  return BrickHistoryNotifier(apiService);
});

class BrickHistoryNotifier extends StateNotifier<List<BrickUseCheckModel>> {
  final HistoryApiService apiService;

  BrickHistoryNotifier(this.apiService) : super([]);

  Future<void> loadBrickList() async {
    try {
      final brickList = await apiService.getBrickUsed();
      state = brickList;
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 사용 기록 조회에 실패했습니다.');
    }
  }

  Future<void> saveBrickHistory(SaveBrickModel request) async {
    try {
      await apiService.postBrickSave(request);
      await loadBrickList();
    } catch(e) {
      develop.log('error: $e');
      throw Exception('브릭 사용 기록 저장에 실패했습니다.');
    }
  }
}
