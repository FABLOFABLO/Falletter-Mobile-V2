import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/answer/data/service/answer_api_service.dart';
import 'package:falletter_mobile_v2/features/answer/data/service/question_api_service.dart';
import 'package:falletter_mobile_v2/features/user/data/service/user_api_service.dart';
import 'package:falletter_mobile_v2/features/answer/data/model/question_model.dart';
import 'package:falletter_mobile_v2/features/user/data/model/student_model.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/user_info_provider.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/provider/progress_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionApiServiceProvider = Provider<QuestionApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return QuestionApiService(dio);
});

final userApiServiceProvider = Provider<UserApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return UserApiService(dio);
});

final answerApiServiceProvider = Provider<AnswerApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return AnswerApiService(dio);
});

final questionListProvider = FutureProvider<List<QuestionModel>>((ref) async {
  final api = ref.read(questionApiServiceProvider);
  return await api.getQuestionList();
});

final selectQuestionListProvider = Provider<List<QuestionModel>>((ref) {
  final progress = ref.watch(progressProvider);
  final questions = ref.watch(questionListProvider);

  if (!progress.hasValue || progress.value == null) return [];

  return questions.when(
    data: (qList) {
      final map = {for (var q in qList) q.id: q};

      return progress.value!.questionIds
          .map((id) => map[id])
          .whereType<QuestionModel>()
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final currentQuestionProvider = Provider<QuestionModel?>((ref) {
  final progress = ref.watch(progressProvider);
  final list = ref.watch(selectQuestionListProvider);

  if (!progress.hasValue || progress.value == null) return null;

  final index = progress.value!.currentIndex;

  if (list.isEmpty) return null;
  if (index >= list.length) return list.last;

  return list[index];
});

final allNamesProvider = FutureProvider<List<StudentModel>>((ref) async {
  final api = ref.read(userApiServiceProvider);
  return await api.getAllStudent();
});

final currentChoicesProvider = Provider<List<StudentModel>>((ref) {
  final progress = ref.watch(progressProvider);
  final studentsAsync = ref.watch(allNamesProvider);
  final userAsync = ref.watch(userInfoProvider);

  if (!progress.hasValue || progress.value == null) return [];

  return studentsAsync.when(
    data: (students) {
      return userAsync.when(
        data: (user) {
          final filtered =
          students.where((e) => e.id != user.id).toList();

          final start = progress.value!.currentIndex * 4;
          final result = filtered.skip(start).take(4).toList();

          if (result.length < 4) {
            final remain = 4 - result.length;
            result.addAll(filtered.take(remain));
          }

          return result;
        },
        loading: () => [],
        error: (_, __) => [],
      );
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final selectedIndexProvider =
StateProvider<int?>((ref) => null);