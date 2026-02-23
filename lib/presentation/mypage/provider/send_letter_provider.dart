import 'package:falletter_mobile_v2/data/repository/letter/send_letter_repository.dart';
import 'package:falletter_mobile_v2/models/send_letter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendLetterRepositoryProvider = Provider<SendLetterRepository>((ref) {
  return SendLetterRepository();
});

final sendLetterProvider =
StateNotifierProvider<SendLetterNotifier, List<SendLetterModel>>((ref) {
  final repository = ref.watch(sendLetterRepositoryProvider);
  return SendLetterNotifier(repository);
});

class SendLetterNotifier extends StateNotifier<List<SendLetterModel>> {
  final SendLetterRepository repository;

  SendLetterNotifier(this.repository) : super(repository.sendLetters());
}