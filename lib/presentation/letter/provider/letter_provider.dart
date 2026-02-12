import 'package:flutter_riverpod/flutter_riverpod.dart';

class LetterState {
  final int count;
  final bool valid;

  LetterState({required this.count, required this.valid});

  LetterState copyWith({int? count, bool? valid}) {
    return LetterState(count: count ?? this.count, valid: valid ?? this.valid);
  }
}

class LetterStateNotifier extends StateNotifier<LetterState> {
  LetterStateNotifier(int letterCount)
    : super(LetterState(count: letterCount, valid: false));

  void decrease() {
    if (state.count > 0) {
      state = state.copyWith(count: state.count - 1);
    }
  }

  void valid(String selectName, String inputStudent, String content) {
    final valid =
        selectName.isNotEmpty &&
        selectName == inputStudent &&
        content.isNotEmpty &&
        state.count > 0;
    state = state.copyWith(valid: valid);
  }
}

final letterProvider = StateNotifierProvider<LetterStateNotifier, LetterState>((
  ref,
) {
  final letterCount = 3;
  return LetterStateNotifier(letterCount);
});
