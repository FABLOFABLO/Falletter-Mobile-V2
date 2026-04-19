import 'dart:developer' as develop;
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/letter/data/service/letter_api_service.dart';
import 'package:falletter_mobile_v2/features/letter/data/model/get_letter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final letterApiServiceProvider = Provider<LetterApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return LetterApiService(dio);
});

final getLetterProvider =
StateNotifierProvider<GetLetterNotifier, List<GetLetterModel>>((ref) {
  final apiService = ref.read(letterApiServiceProvider);
  return GetLetterNotifier(apiService);
});

class GetLetterNotifier extends StateNotifier<List<GetLetterModel>> {
  final LetterApiService apiService;

  GetLetterNotifier(this.apiService) : super([]);

  Future<void> getLetterList() async {
    try {
      final letters = await apiService.getLetterAll();
      state = letters;
    } catch(e) {
      develop.log('error: $e');
      throw Exception('받은 레터 목록 조회에 실패했습니다.');
    }
  }
}