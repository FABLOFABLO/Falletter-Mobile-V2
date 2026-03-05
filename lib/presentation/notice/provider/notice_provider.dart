import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/models/notice_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notice_api_service.dart';

final brickCountProvider = StateProvider<int>((ref) => 5);

final unlockedHintsProvider = StateProvider.family<List<int>, int>(
  (ref, noticeIndex) => [],
);

final noticeApiServiceProvider = Provider<NoticeApiService>((ref) {
  final client = ref.watch(dioClientProvider);
  return NoticeApiService(client.dio);
});

class NoticeListState {
  final List<NoticeItem> notices;
  final bool isLoading;
  final String? error;

  const NoticeListState({
    this.notices = const [],
    this.isLoading = false,
    this.error,
  });

  NoticeListState copyWith({
    List<NoticeItem>? notices,
    bool? isLoading,
    String? error,
  }) {
    return NoticeListState(
      notices: notices ?? this.notices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class NoticeListNotifier extends StateNotifier<NoticeListState> {
  final NoticeApiService _apiService;

  NoticeListNotifier(this._apiService) : super(const NoticeListState());

  Future<void> loadNotices() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final notices = await _apiService.getNoticeList();
      state = state.copyWith(notices: notices, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    await loadNotices();
  }
}

final noticeListProvider =
    StateNotifierProvider<NoticeListNotifier, NoticeListState>((ref) {
      final apiService = ref.watch(noticeApiServiceProvider);
      return NoticeListNotifier(apiService);
    });

class NoticeDetailNotifier extends StateNotifier<AsyncValue<NoticeDetail>> {
  final NoticeApiService _apiService;
  final String _noticeId;

  NoticeDetailNotifier(this._apiService, this._noticeId)
    : super(const AsyncValue.loading());

  Future<void> loadNoticeDetail(String? noticeId) async {
    final id = noticeId ?? _noticeId;

    state = const AsyncValue.loading();

    try {
      final detail = await _apiService.getNoticeDetail(id);
      state = AsyncValue.data(detail);

      _apiService.markAsRead(id);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> unlockHint(int hintIndex) async {
    final currentDetail = state.value;
    if (currentDetail == null) return;

    if (currentDetail.unlockedHints.contains(hintIndex)) return;

    try {
      await _apiService.unlockHint(noticeId: _noticeId, hintIndex: hintIndex);

      final updatedDetail = currentDetail.copyWith(
        unlockedHints: [...currentDetail.unlockedHints, hintIndex],
      );

      state = AsyncValue.data(updatedDetail);
    } catch (e, stack) {
      state = AsyncValue.data(currentDetail);
      rethrow;
    }
  }

  Future<void> refresh() async {
    await loadNoticeDetail(null);
  }
}

final noticeDetailProvider =
    StateNotifierProvider.family<
      NoticeDetailNotifier,
      AsyncValue<NoticeDetail>,
      String
    >((ref, noticeId) {
      final apiService = ref.watch(noticeApiServiceProvider);
      return NoticeDetailNotifier(apiService, noticeId);
    });

final hintBrickCostProvider = Provider.family<int, int>((ref, hintIndex) {
  return hintIndex + 1;
});

final cumulativeBrickCostProvider = Provider.family<int, int>((ref, hintIndex) {
  final n = hintIndex + 1;
  return (n * (n + 1)) ~/ 2;
});
