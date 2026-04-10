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

class QuizNotifier extends Notifier<QuizItem?> {
  late List<QuestionModel> questions;
  late List<StudentModel> students;
  late UserInfoModel user;

  @override
  QuizItem? build() {
    return null;
  }

  Future<void> init() async {
    questions = await ref.read(questionListProvider.future);
    students = await ref.read(allNamesProvider.future);
    await ref.read(userInfoProvider.notifier).getUserInfo();
    final userAsync = ref.read(userInfoProvider);
    user = userAsync.when(
      data: (data) => data,
      loading: () => throw Exception('로딩 중'),
      error: (e, st) => throw e,
    );
    questions.shuffle();
    students.shuffle();
    _setQuiz(0);
  }

  List<String> _createChoices(int index) {
    final filtered = students.where((e) => e.id != user.id).toList();
    final result = filtered.skip(index * 4).take(4).map((e) => e.name).toList();
    if (result.length < 4) {
      final remain = 4 - result.length;
      result.addAll(
        filtered.take(remain).map((e) => e.name),
      );
    }
    return result;
  }

  void _setQuiz(int index) {
    final question = questions[index];
    final choices = _createChoices(index);

    state = QuizItem(
      question: question,
      choices: choices,
    );
  }

  void nextQuestion() {
    ref.read(selectedIndexProvider.notifier).state = null;
    final nextIndex = ref.read(currentIndexProvider) + 1;
    ref.read(currentIndexProvider.notifier).state = nextIndex;
    _setQuiz(nextIndex);
  }
}

final quizProvider = NotifierProvider<QuizNotifier, QuizItem?>(() {
  return QuizNotifier();
});