import 'package:falletter_mobile_v2/models/question_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AnswerState {
  answering,
  waiting,
}

final currentIndexProvider = StateProvider<int>((ref) => 0);

final questionListProvider = Provider<List<QuestionModel>>((ref) => [
  QuestionModel(
    id: 1,
    question: '감수성이 풍부한 사람',
    emoji: '🎧',
  ),
  QuestionModel(
    id: 2,
    question: '리더십이 뛰어난 사람',
    emoji: '🧭',
  ),
  QuestionModel(
    id: 3,
    question: '분위기를 잘 읽는 사람',
    emoji: '👀',
  ),
  QuestionModel(
    id: 4,
    question: '가장 친한 친구는?',
    emoji: '😊',
  ),
  QuestionModel(
    id: 5,
    question: '아이디어가 많은 사람',
    emoji: '💡',
  ),
]);

final allNamesProvider = Provider<List<String>>((ref) => [
  '홍길동1', '홍길동2', '홍길동3', '홍길동4'
]);

final selectedIndexProvider = StateProvider<int?>((ref) => null);

class AnswerNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return _createAnswerChoices();
  }

  List<String> _createAnswerChoices() {
    final all = ref.read(allNamesProvider);
    final shuffled = [...all]..shuffle();
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