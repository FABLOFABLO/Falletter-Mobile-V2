import 'dart:developer' as develop;

import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/item_api_service.dart';
import 'package:falletter_mobile_v2/models/letter_count_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LetterState {
  final LetterCountModel count;
  final bool valid;

  LetterState({required this.count, required this.valid});

  LetterState copyWith({LetterCountModel? count, bool? valid}) {
    return LetterState(count: count ?? this.count, valid: valid ?? this.valid);
  }
}

final itemApiServiceProvider = Provider<ItemApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return ItemApiService(dio);
});

class LetterStateNotifier extends StateNotifier<AsyncValue<LetterState>> {
  final ItemApiService apiService;
  LetterStateNotifier(this.apiService) : super(AsyncValue.loading());

  bool valid({
    required String selectName,
    required String inputStudent,
    required String content,
  }) {
    final current = state.value;
    if (current == null) return false;

    final nameValid = selectName.isNotEmpty && selectName == inputStudent;
    final contentValid = content.trim().isNotEmpty;
    final countValid = current.count.letterCount > 0;

    final valid = nameValid && contentValid && countValid;
    state = AsyncValue.data(current.copyWith(valid: valid));
    return valid;
  }

  Future<void> loadLetterCount() async {
    try {
      final count = await apiService.getLetterCount();
      state = AsyncValue.data(LetterState(count: count, valid: false));
    } catch(e) {
      develop.log('error: $e');
    }
  }

  Future<void> updateLetterCount(int letterUpdate) async {
    try {
      await apiService.updateLetterCount(letterUpdate);
      await loadLetterCount();
    } catch(e) {
      develop.log('error: $e');
    }
  }
}

final letterProvider = StateNotifierProvider<LetterStateNotifier, AsyncValue<LetterState>>(
  (ref) {
   final apiService = ref.read(itemApiServiceProvider);
   return LetterStateNotifier(apiService);
  },
);
