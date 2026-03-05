import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'answer_provider.dart';

class AnswerTimerNotifier extends Notifier<Duration> {
  static const Duration _initialCountdown = Duration(hours: 4);
  Timer? _timer;

  @override
  Duration build() {
    return _initialCountdown;
  }

  double get progress {
    return _initialCountdown.inSeconds > 0
        ? state.inSeconds / _initialCountdown.inSeconds : 0.0;
  }

  String get hours {
    return state.inHours.toString().padLeft(2, '0');
  }

  String get minutes {
    return state.inMinutes.remainder(60).toString().padLeft(2, '0');
  }

  void startCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.inSeconds > 0) {
        state = state - const Duration(seconds: 1);
      }
      else {
        timer.cancel();
        ref.read(answerStateProvider.notifier).state = AnswerState.answering;
        ref.read(currentIndexProvider.notifier).state = 0;
        ref.read(selectedIndexProvider.notifier).state = null;

        state = _initialCountdown;
      }
    });
  }
}

final answerTimerProvider = NotifierProvider<AnswerTimerNotifier, Duration>(
    () => AnswerTimerNotifier()
);