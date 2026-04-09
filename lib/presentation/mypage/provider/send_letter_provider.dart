import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/letter_api_service.dart';
import 'package:falletter_mobile_v2/models/letter_model.dart';
import 'package:falletter_mobile_v2/models/send_letter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final letterApiServiceProvider = Provider<LetterApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return LetterApiService(dio);
});

final sendLetterProvider =
StateNotifierProvider<SendLetterNotifier, List<SendLetterModel>>((ref) {
  final apiService = ref.watch(letterApiServiceProvider);
  return SendLetterNotifier(apiService);
});

class SendLetterNotifier extends StateNotifier<List<SendLetterModel>> {
  final LetterApiService apiService;

  SendLetterNotifier(this.apiService) : super([]);

  Future<void> getSendLetters() async {
    try {
      final letters = await apiService.getSendLetterAll();
      state = letters;
    } catch(e) {
      throw Exception('보낸 레터 목록 조회에 실패했습니다. $e');
    }
  }

  Future<void> sendLetter(LetterModel request) async {
    try {
      await apiService.postLetter(request);
    } catch(e) {
      throw Exception('편지 발송에 실패했습니다. $e');
    }
  }
}