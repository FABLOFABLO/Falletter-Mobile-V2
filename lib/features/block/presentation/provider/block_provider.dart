import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/block/data/model/blocked_post_model.dart';
import 'package:falletter_mobile_v2/features/block/data/service/block_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blockApiServiceProvider = Provider<BlockApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return BlockApiService(dio);
});

final blockListProvider =
    StateNotifierProvider<BlockListNotifier, AsyncValue<List<BlockedPostModel>>>(
  (ref) => BlockListNotifier(ref.read(blockApiServiceProvider)),
);

class BlockListNotifier
    extends StateNotifier<AsyncValue<List<BlockedPostModel>>> {
  final BlockApiService apiService;

  BlockListNotifier(this.apiService) : super(const AsyncValue.loading());

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await apiService.getBlockedPosts());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> block(int postId) async {
    await apiService.blockByPost(postId);
  }

  Future<void> unblock(int blockId) async {
    await apiService.unblock(blockId);
    final current = state.value ?? [];
    state = AsyncValue.data(
      current.where((e) => e.blockId != blockId).toList(),
    );
  }
}
