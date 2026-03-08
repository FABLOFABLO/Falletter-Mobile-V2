import 'dart:async';
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/models/timer_model.dart';
import 'package:falletter_mobile_v2/core/providers/timer_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rouletteTimerApiServiceProvider = Provider<TimerApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return TimerApiService(dio);
});

final rouletteTimerProvider = StateNotifierProvider<RouletteTimerNotifier, TimerModel?>(
    (ref) {
      final apiService = ref.read(rouletteTimerApiServiceProvider);
      return RouletteTimerNotifier(apiService);
    }
);

class RouletteTimerNotifier extends StateNotifier<TimerModel?> {
  final TimerApiService apiService;

  RouletteTimerNotifier(this.apiService) : super(null);

  Future<void> loadRouletteTimer() async {
    try {
      final timer = await apiService.getRouletteTimer();
      state = timer;
    } catch(e) {
      throw Exception('룰렛 타이머 조회에 실패했습니다.');
    }
  }

  Future<void> startRouletteTimer() async {
    try {
      await apiService.startRouletteTimer();
      await loadRouletteTimer();
    } catch(e) {
      throw Exception('룰렛 타이머 시작에 실패했습니다.');
    }
  }
}

final rouletteCountdownProvider = StateNotifierProvider<rouletteCountdownNotifier, int>(
        (ref) => rouletteCountdownNotifier()
);

class rouletteCountdownNotifier extends StateNotifier<int> {
  Timer? _timer;

  rouletteCountdownNotifier() : super(0);

  void startTimer(int remainingSeconds) {
    state = remainingSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 0 || !mounted) {
        timer.cancel();
        return;
      }
      state--;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}