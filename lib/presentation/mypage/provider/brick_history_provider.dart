import 'package:falletter_mobile_v2/models/brick_use_check_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brickHistoryProvider =
    StateNotifierProvider<BrickHistoryNotifier, List<BrickUseCheckModel>>(
      (ref) => BrickHistoryNotifier(),
    );

class BrickHistoryNotifier extends StateNotifier<List<BrickUseCheckModel>> {
  BrickHistoryNotifier() : super(brickHistory);

  static final List<BrickUseCheckModel> brickHistory = [
    BrickUseCheckModel(
      id: 1,
      description: '3학년 여학생의 선택',
      amount: -2,
      type: 'QUESTION',
      question: 'T 100% 일것 같은 사람',
      targetUserId: 1,
      writerUserId: 2,
      gender: 'FEMALE',
      schoolNumber: '3301',
      createdAt: DateTime.now(),
    ),
    BrickUseCheckModel(
      id: 2,
      description: '1학년 여학생의 선택',
      amount: -2,
      type: 'QUESTION',
      question: 'T 100% 일것 같은 사람',
      targetUserId: 2,
      writerUserId: 3,
      gender: 'FEMALE',
      schoolNumber: '3301',
      createdAt: DateTime.parse('2026-03-05 14:30'),
    ),
    BrickUseCheckModel(
      id: 3,
      description: '2학년 여학생의 선택',
      amount: -2,
      type: 'QUESTION',
      question: '웃는게 예쁜 사람',
      targetUserId: 4,
      writerUserId: 5,
      gender: 'FEMALE',
      schoolNumber: '3301',
      createdAt: DateTime.parse('2025-10-20 12:30'),
    ),
    BrickUseCheckModel(
      id: 5,
      description: '출석 보상',
      amount: 2,
      type: 'ATTENDANCE',
      question: '',
      targetUserId: 5,
      writerUserId: 6,
      gender: 'FEMALE',
      schoolNumber: '3301',
      createdAt: DateTime.parse('2026-02-02'),
    ),
  ];
}
