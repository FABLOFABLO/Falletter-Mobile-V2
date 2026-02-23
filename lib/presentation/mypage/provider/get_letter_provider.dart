import 'package:falletter_mobile_v2/data/repository/letter/get_letter_repository.dart';
import 'package:falletter_mobile_v2/models/get_letter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getLetterRepositoryProvider = Provider<GetLetterRepository>((ref) {
  return GetLetterRepository();
});

final getLetterProvider =
StateNotifierProvider<GetLetterNotifier, List<GetLetterModel>>((ref) {
  final repository = ref.watch(getLetterRepositoryProvider);
  return GetLetterNotifier(repository);
});

class GetLetterNotifier extends StateNotifier<List<GetLetterModel>> {
  final GetLetterRepository repository;

  GetLetterNotifier(this.repository) : super(repository.getLetterDummy);
}