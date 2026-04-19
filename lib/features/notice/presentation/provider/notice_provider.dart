import 'dart:async';
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
  NoticeItem? _noticeItem;

  NoticeDetailNotifier(this._apiService) : super(const AsyncValue.loading());

  void initFromNoticeItem(NoticeItem item) {
    _noticeItem = item;
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
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveHint({
    required int answerId,
    required String firstHint,
    String secondHint = '',
    String thirdHint = '',
  }) async {
    try {
      final hintId = await _apiService.saveHint(
        answerId: answerId,
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      _updateLocalHint(
        hintId: hintId > 0 ? hintId : null,
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      if (_noticeItem != null) {
        await _apiService.saveBrickHistory(
          title: '힌트 사용',
          description: '첫 번째 힌트 열람',
          amount: 1,
          type: 'QUESTION',
          questionId: _noticeItem!.questionId,
          targetUserId: _noticeItem!.targetUserId,
          writerUserId: _noticeItem!.writerUserId,
        );
      }

      if (hintId <= 0) {
        await fetchHint(answerId);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateHint({
    required int answerId,
    int? hintId,
    required String firstHint,
    required String secondHint,
    required String thirdHint,
  }) async {
    try {
      await _apiService.updateHint(
        answerId: answerId,
        hintId: hintId,
        firstHint: firstHint,
        secondHint: secondHint,
        thirdHint: thirdHint,
      );

      _updateLocalHint(
        hintId: hintId,
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

  Future<bool> unlockNextHint({
    required int answerId,
    int? hintId,
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
      answerId: answerId,
      hintId: hintId,
      firstHint: firstHint,
      secondHint: secondHint,
      thirdHint: thirdHint,
    );

    if (success && _noticeItem != null) {
      final descriptions = ['첫 번째 힌트 열람', '두 번째 힌트 열람', '세 번째 힌트 열람'];
      await _apiService.saveBrickHistory(
        title: '힌트 사용',
        description: descriptions[unlockedCount],
        amount: unlockedCount + 1,
        type: 'QUESTION',
        questionId: _noticeItem!.questionId,
        targetUserId: _noticeItem!.targetUserId,
        writerUserId: _noticeItem!.writerUserId,
      );
    }

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
