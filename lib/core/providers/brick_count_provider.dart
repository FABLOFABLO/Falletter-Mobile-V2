import 'dart:developer' as develop;
import 'package:falletter_mobile_v2/core/providers/item_api_service.dart';
import 'package:falletter_mobile_v2/models/brick_count_model.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brickCountProvider =
StateNotifierProvider<BrickCountStateNotifier, AsyncValue<BrickCountModel>>((ref) {
  final apiService = ref.read(itemApiServiceProvider);
  return BrickCountStateNotifier(apiService);
});

class BrickCountStateNotifier extends StateNotifier<AsyncValue<BrickCountModel>> {
  final ItemApiService apiService;
  BrickCountStateNotifier(this.apiService) : super(AsyncValue.loading());

  Future<void> loadBrickCount() async {
    try {
      final count = await apiService.getBrickCount();
      state = AsyncValue.data(count);
    } catch(e) {
      develop.log('error: $e');
    }
  }

  Future<void> updateBrickCount(int brickUpdate) async {
    try {
      await apiService.updateBrickCount(brickUpdate);
      await loadBrickCount();
    } catch(e) {
      develop.log('error: $e');
    }
  }
}
