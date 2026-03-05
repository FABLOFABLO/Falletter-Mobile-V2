import 'package:falletter_mobile_v2/models/roulette_timer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rouletteTimerProvider =
StateProvider<RouletteTimerModel?>((ref) => null);

Future<void> loadDummyRouletteTimer(WidgetRef ref) async {
  await Future.delayed(const Duration(milliseconds: 500));

  final dummy = RouletteTimerModel(
    userId: 1,
    remainingSeconds: 0,
    isActive: false,
  );

  ref.read(rouletteTimerProvider.notifier).state = dummy;
}