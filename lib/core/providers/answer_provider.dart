import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/user_api_service.dart';
import 'package:falletter_mobile_v2/models/question_model.dart';
import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:falletter_mobile_v2/presentation/answer/provider/question_api_service.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final questionApiServiceProvider = Provider<QuestionApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return QuestionApiService(dio);
});

final userApiServiceProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});

final questionListProvider = FutureProvider<List<QuestionModel>>((ref) async {
  final apiService = ref.read(questionApiServiceProvider);
  final list = await apiService.getQuestionList();
  final shuffle = [...list]..shuffle();
  return shuffle;
});

final allNamesProvider = FutureProvider<List<StudentModel>>((ref) async {
  final apiService = ref.read(userApiServiceProvider);
  final list = await apiService.getAllStudent();
  return list;
});

final selectedIndexProvider = StateProvider<int?>((ref) => null);

class AnswerNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return _createAnswerChoices();
  }

  List<String> _createAnswerChoices() {
    final allAsync = ref.watch(allNamesProvider);
    final userAsync = ref.watch(userInfoProvider);
    final used = ref.watch(userNamesProvider);

    if (!allAsync.hasValue || !userAsync.hasValue) return [];

    final all = allAsync.value!;
    final userInfo = userAsync.value!;

    final filtered = all.where((e) => e.id != userInfo.id).toList();

    final names = filtered.map((e) => e.name).where((name) => !used.contains(name)).toList();
    final shuffled = [...names]..shuffle();

    return shuffled.take(4).toList();
  }

  void nextQuestion() {
    ref.read(currentIndexProvider.notifier).state++;
    ref.read(selectedIndexProvider.notifier).state = null;
    state = _createAnswerChoices();
  }
}

final answerProvider = NotifierProvider<AnswerNotifier, List<String>>(() =>
    AnswerNotifier());

final userNamesProvider = StateProvider<Set<String>>((ref) => {});