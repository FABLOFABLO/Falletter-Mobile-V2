import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/post/data/service/report_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportApiServiceProvider = Provider<ReportApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return ReportApiService(dio);
});

final reportProvider = StateNotifierProvider<ReportNotifier, void>((ref) {
  final apiService = ref.read(reportApiServiceProvider);
  return ReportNotifier(apiService);
});

class ReportNotifier extends StateNotifier<void> {
  final ReportApiService apiService;

  ReportNotifier(this.apiService) : super(null);

  Future<void> addReport(int contentId, String reason) async {
    await apiService.reportPost(contentId: contentId, reason: reason);
  }
}