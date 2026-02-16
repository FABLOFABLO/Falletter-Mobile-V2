import 'package:falletter_mobile_v2/core/providers/letter_count_provider.dart';
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

  bool valid({
    required String selectName,
    required String inputStudent,
    required String content,
  }) {
    final nameValid = selectName.isNotEmpty && selectName == inputStudent;
    final contentValid = content.trim().isNotEmpty;
    final countValid = state.count > 0;
        final valid = nameValid && contentValid && countValid;
    state = state.copyWith(valid: valid);
    return valid;
  }
}

final letterProvider = StateNotifierProvider<LetterStateNotifier, LetterState>(
  (ref) {
   final letterCount =  ref.watch(letterCountProvider);
   return LetterStateNotifier(letterCount.letterCount);
  },
);
