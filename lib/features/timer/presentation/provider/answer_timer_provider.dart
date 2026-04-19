import 'dart:async';
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/timer/data/service/timer_api_service.dart';
import 'package:falletter_mobile_v2/features/timer/data/model/timer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final answerTimerApiServiceProvider = Provider<TimerApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return TimerApiService(dio);
});

final answerTimerProvider = StateNotifierProvider<AnswerTimerNotifier, TimerModel?>(
    (ref) {
      final apiService = ref.read(answerTimerApiServiceProvider);
      return AnswerTimerNotifier(apiService);
    }
);

class AnswerTimerNotifier extends StateNotifier<TimerModel?> {
  final TimerApiService apiService;

  AnswerTimerNotifier(this.apiService) : super(null);

  Future<void> loadAnswerTimer() async {
    try {
      final timer = await apiService.getBrickTimer();
      state = timer;
    } catch(e) {
      throw Exception('답변 타이머 조회에 실패했습니다.');
    }
  }

  Future<void> startAnswerTimer() async {
    try {
      await apiService.startBrickTimer();
      state = await apiService.getBrickTimer();
    } catch(e) {
      throw Exception('답변 타이머 시작에 실패했습니다.');
    }
  }
 }

 final answerCountdownProvider = StateNotifierProvider<AnswerCountdownNotifier, int>(
     (ref) => AnswerCountdownNotifier()
 );

 class AnswerCountdownNotifier extends StateNotifier<int> {
   Timer? _timer;

   AnswerCountdownNotifier() : super(0);

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