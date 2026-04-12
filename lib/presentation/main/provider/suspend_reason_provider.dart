import 'package:falletter_mobile_v2/models/suspend_reason_model.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/suspend_api_service.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/suspend_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final suspendReasonProvider =
    StateNotifierProvider<SuspendReasonNotifier, SuspendReasonModel?>((ref) {
      final apiService = ref.read(suspendApiServiceProvider);
      return SuspendReasonNotifier(apiService);
    });

class SuspendReasonNotifier extends StateNotifier<SuspendReasonModel?> {
  final SuspendApiService apiService;

  SuspendReasonNotifier(this.apiService) : super(null);

  Future<void> loadSuspendReason(int suspendId) async {
    try {
      final reason = await apiService.getSuspendReason(suspendId);
      state = reason;
    } catch (e) {
      throw Exception('정지 사유 조회에 실패했습니다.');
    }
  }
}
