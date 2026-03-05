import 'package:falletter_mobile_v2/models/brick_count_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brickCountProvider =
StateNotifierProvider<BrickCountStateNotifier, BrickCountModel>(
      (ref) => BrickCountStateNotifier(),
);

class BrickCountStateNotifier extends StateNotifier<BrickCountModel> {
  BrickCountStateNotifier() : super(BrickCountModel(brickCount: 1, userId: 1));

  void increase() {
    state = state.copyWith(brickCount: state.brickCount + 1);
  }

  void decrease() {
    state = state.copyWith(brickCount: state.brickCount - 1);
  }
}
