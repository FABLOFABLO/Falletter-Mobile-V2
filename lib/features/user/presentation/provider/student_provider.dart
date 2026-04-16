import 'dart:developer' as develop;
import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/user/data/api/user_api_service.dart';
import 'package:falletter_mobile_v2/features/user/data/model/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiService = Provider<UserApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return UserApiService(dio);
});

final studentProvider = StateNotifierProvider<StudentNotifier, List<StudentModel>>((ref) {
  final apiService = ref.watch(userApiService);
  return StudentNotifier(apiService);
});

class StudentNotifier extends StateNotifier<List<StudentModel>> {
  final UserApiService apiService;

  StudentNotifier(this.apiService) : super([]) {
    loadStudents();
  }

  Future<void> loadStudents() async {
    try {
      final students = await apiService.getAllStudent();
      state = students;
    } catch(e) {
      develop.log('error: $e');
      throw Exception('학생 목록 조회 실패');
    }
  }
}

