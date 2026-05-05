import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/features/answer/data/model/progress_model.dart';
import 'package:falletter_mobile_v2/features/answer/data/service/answer_api_service.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/provider/answer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressProvider = StateNotifierProvider<ProgressNotifier,
    AsyncValue<ProgressModel?>>((ref) {
  final apiService = ref.read(answerApiServiceProvider);
  return ProgressNotifier(apiService);
});

class ProgressNotifier extends StateNotifier<AsyncValue<ProgressModel?>> {
  final AnswerApiService apiService;
  bool hasTriedCreate = false;

  ProgressNotifier(this.apiService) : super(AsyncValue.loading());

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> loadProgress() async {
    try {
      final progress = await apiService.getProgress();
      state = AsyncValue.data(progress);
    } on DioException catch (e) {
      if (!hasTriedCreate || e.response?.statusCode == 404) {
        hasTriedCreate = true;
        await apiService.createProgress();
        final progress = await apiService.getProgress();
        state = AsyncValue.data(progress);
        return;
      }

      state = const AsyncValue.data(null);
      return;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> skipProgress() async {
    try {
      final progress = await apiService.skipProgress();
      state = AsyncValue.data(progress);
    } catch(e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createProgress() async {
    try {
      await apiService.createProgress();
      await loadProgress();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> completeProgress() async {
    try {
      await apiService.completeProgress();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}