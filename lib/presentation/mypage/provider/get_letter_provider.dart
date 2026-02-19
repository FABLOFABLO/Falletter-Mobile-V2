import 'package:falletter_mobile_v2/models/get_letter_model.dart';
import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getLetterDummy = [
  GetLetterModel(
    id: 1,
    content: '안녕하십니까',
    isDelivered: true,
    isPassed: true,
    receptionId: 1,
    senderId: 1,
    createdAt: DateTime.parse('2025-10-20'),
    get: StudentModel(id: 1, schoolNumber: '3301', name: '강해민')
  ),
  GetLetterModel(
    id: 2,
    content: '안녕하십니까',
    isDelivered: true,
    isPassed: true,
    receptionId: 2,
    senderId: 2,
    createdAt: DateTime.parse('2026-02-11'),
      get: StudentModel(id: 1, schoolNumber: '3301', name: '강해민')
  ),
  GetLetterModel(
    id: 3,
    content: '안녕하십니까',
    isDelivered: true,
    isPassed: true,
    receptionId: 3,
    senderId: 3,
    createdAt: DateTime.parse('2026-02-13'),
      get: StudentModel(id: 1, schoolNumber: '3301', name: '강해민')
  ),
];
final getLetterProvider =
    StateNotifierProvider<GetLetterNotifier, List<GetLetterModel>>(
      (ref) => GetLetterNotifier(),
    );

class GetLetterNotifier extends StateNotifier<List<GetLetterModel>> {
  GetLetterNotifier() : super(getLetterDummy);
}
