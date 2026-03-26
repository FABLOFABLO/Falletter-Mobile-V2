import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/user_api_service.dart';
import 'package:falletter_mobile_v2/models/my_info_model.dart';
import 'package:falletter_mobile_v2/models/question_model.dart';
import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:falletter_mobile_v2/presentation/answer/provider/question_api_service.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

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

final selectedIndexProvider = StateProvider.autoDispose<int?>((ref) => null);

final userNamesProvider = StateProvider.autoDispose<Set<String>>((ref) => {});

class QuizItem {
  final QuestionModel question;
  final List<String> choices;

  QuizItem({
    required this.question,
    required this.choices,
  });
}

class QuizNotifier extends AsyncNotifier<QuizItem> {
  @override
  Future<QuizItem> build() async {
    final questions = await ref.watch(questionListProvider.future);
    final students = await ref.watch(allNamesProvider.future);
    final user = await ref.watch(userInfoProvider.future);
    final index = ref.watch(currentIndexProvider);

    final question = questions[index];
    final choices = _createChoices(students, user, index);

    return QuizItem(
      question: question,
      choices: choices,
    );
  }

  List<String> _createChoices(
      List<StudentModel> all,
      UserInfoModel user,
      int index,
      ) {
    final filtered = all.where((e) => e.id != user.id).toList();
    final names = filtered.map((e) => e.name).toList();

    final shuffled = [...names]..shuffle();

    return shuffled.take(4).toList();
  }

  void nextQuestion() {
    ref.read(currentIndexProvider.notifier).state++;
    ref.read(selectedIndexProvider.notifier).state = null;
  }
}

final quizProvider =
AsyncNotifierProvider<QuizNotifier, QuizItem>(() {
  return QuizNotifier();
});