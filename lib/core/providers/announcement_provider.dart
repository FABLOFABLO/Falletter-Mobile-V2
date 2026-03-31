import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/announcement_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/models/announcement_model.dart';

final announcementApiServiceProvider = Provider<AnnouncementApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return AnnouncementApiService(dio);
});

final announcementProvider =
    StateNotifierProvider<AnnouncementNotifier, List<AnnouncementModel>>((ref) {
      final apiService = ref.read(announcementApiServiceProvider);
      return AnnouncementNotifier(apiService);
    });

class AnnouncementNotifier extends StateNotifier<List<AnnouncementModel>> {
  final AnnouncementApiService apiService;

  AnnouncementNotifier(this.apiService) : super([]);

  Future<void> loadAnnouncementList() async {
    try {
      final announcements = await apiService.getNoticeList();
      state = announcements;
    } catch (e) {
      throw Exception('공지사항 목록 조회에 실패했습니다.');
    }
  }
}
