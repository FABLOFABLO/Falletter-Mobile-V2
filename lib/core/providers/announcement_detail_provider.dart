import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/core/providers/announcement_provider.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/announcement_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/models/announcement_detail_model.dart';

final announcementApiService = Provider<AnnouncementApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return AnnouncementApiService(dio);
});

final announcementDetailProvider =
    StateNotifierProvider<AnnouncementDetailNotifier, AnnouncementDetailModel?>(
      (ref) {
        final apiService = ref.read(announcementApiServiceProvider);
        return AnnouncementDetailNotifier(apiService);
      },
    );

class AnnouncementDetailNotifier
    extends StateNotifier<AnnouncementDetailModel?> {
  final AnnouncementApiService apiService;

  AnnouncementDetailNotifier(this.apiService) : super(null);

  Future<void> loadDetailAnnouncement(int announcementId) async {
    try {
      final announcement = await apiService.getNotice(announcementId);
      state = announcement;
    } catch (e) {
      throw Exception('공지사항 조회에 실패했습니다.');
    }
  }
}
