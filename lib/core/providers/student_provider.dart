import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentNotifier extends StateNotifier<List<StudentModel>> {
  StudentNotifier() : super(dummy);
}

final studentProvider =
    StateNotifierProvider<StudentNotifier, List<StudentModel>>(
      (ref) => StudentNotifier(),
    );
/// 연동할때 FutureProvider로 바꾸기
final dummy = [
  StudentModel(id: 1, schoolNumber: '1216', name: '최승우'),
  StudentModel(id: 2, schoolNumber: '1411', name: '이승현'),
  StudentModel(id: 3, schoolNumber: '3310', name: '유지우'),
  StudentModel(id: 4, schoolNumber: '1212', name: '이지아'),
];

