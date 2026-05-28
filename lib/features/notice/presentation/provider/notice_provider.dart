import 'dart:async';
import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/notice/data/model/notice_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/service/notice_api_service.dart';

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
  Timer? _autoRefreshTimer;

  NoticeListNotifier(this._apiService) : super(const NoticeListState()) {
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => loadNotices(),
    );
  }

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

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }
}

final noticeListProvider =
    StateNotifierProvider<NoticeListNotifier, NoticeListState>((ref) {
      final apiService = ref.watch(noticeApiServiceProvider);
      return NoticeListNotifier(apiService);
    });

class NoticeDetailNotifier extends StateNotifier<AsyncValue<NoticeDetail>> {
  final NoticeApiService _apiService;

  NoticeDetailNotifier(this._apiService) : super(const AsyncValue.loading());

  void initFromNoticeItem(NoticeItem item) {
    final currentHint = state.valueOrNull?.hintData;
    state = AsyncValue.data(
      NoticeDetail.fromNoticeItem(item).copyWith(hintData: currentHint),
    );
  }

  void _updateLocalHint({
    required String firstHint,
    required String secondHint,
    required String thirdHint,
    int? hintId,
  }) {
    final currentDetail = state.valueOrNull;
    if (currentDetail == null) return;

    final previousHint = currentDetail.hintData;

    final nextHint = HintData(
      id: hintId ?? previousHint?.id ?? 0,
      firstHint: firstHint,
      secondHint: secondHint,
      thirdHint: thirdHint,
      userId: previousHint?.userId ?? 0,
    );

    state = AsyncValue.data(currentDetail.copyWith(hintData: nextHint));
  }

  HintData _preferMoreUnlockedHint(HintData current, HintData incoming) {
    if (incoming.unlockedCount >= current.unlockedCount) {
      return incoming;
    }

    return current;
  }

  Future<HintData?> fetchHint(int answerId) async {
    try {
      final fetchedHint = await _apiService.getHint(answerId: answerId);

      final currentDetail = state.value;

      if (currentDetail != null) {
        final currentHint = currentDetail.hintData;

        final resolvedHint = currentHint == null
            ? fetchedHint
            : _preferMoreUnlockedHint(currentHint, fetchedHint);

        state = AsyncValue.data(currentDetail.copyWith(hintData: resolvedHint));
      }

      return fetchedHint;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }

      rethrow;
    }
  }

  Future<bool> saveHint({
    required int answerId,
    required String firstHint,
    String secondHint = '',
    String thirdHint = '',
  }) async {
    try {
      await _apiService.saveHint(
        answerId: answerId,
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      await fetchHint(answerId);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateHint({
    required int hintId,
    required String firstHint,
    required String secondHint,
    required String thirdHint,
  }) async {
    try {
      await _apiService.updateHint(
        hintId: hintId,
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      _updateLocalHint(
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unlockNextHint({
    required int hintId,
    required HintData currentHint,
    required String newHintValue,
  }) async {
    final unlockedCount = currentHint.unlockedCount;

    if (unlockedCount >= 3) {
      return false;
    }

    String firstHint = currentHint.firstHint;
    String secondHint = currentHint.secondHint;
    String thirdHint = currentHint.thirdHint;

    switch (unlockedCount) {
      case 0:
        firstHint = newHintValue;
        break;
      case 1:
        secondHint = newHintValue;
        break;
      case 2:
        thirdHint = newHintValue;
        break;
    }

    final success = await updateHint(
      hintId: hintId,
      firstHint: firstHint,
      secondHint: secondHint,
      thirdHint: thirdHint,
    );

    return success;
  }

  Future<void> refresh(int answerId) async {
    await fetchHint(answerId);
  }
}

final noticeDetailProvider =
    StateNotifierProvider.family<
      NoticeDetailNotifier,
      AsyncValue<NoticeDetail>,
      String
    >((ref, noticeId) {
      final apiService = ref.watch(noticeApiServiceProvider);
      return NoticeDetailNotifier(apiService);
    });

final hintBrickCostProvider = Provider.family<int, int>((ref, hintIndex) {
  return hintIndex + 1;
});

final cumulativeBrickCostProvider = Provider.family<int, int>((ref, hintIndex) {
  final n = hintIndex + 1;
  return (n * (n + 1)) ~/ 2;
});
