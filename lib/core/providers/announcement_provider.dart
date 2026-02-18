import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/models/announcement_model.dart';

final dummyAnnouncement = [
  AnnouncementModel(
      id: 1,
      title: '공지 제목',
      authorName: '관리자1',
      createdAt: DateTime(2025, 6, 12)
  ),
  AnnouncementModel(
      id: 2,
      title: '공지 제목입니다.',
      authorName: '관리자2',
      createdAt: DateTime(2025, 3, 12)
  ),
  AnnouncementModel(
      id: 3,
      title: '공지 제목 공지제목',
      authorName: '관리자3',
      createdAt: DateTime(2024, 6, 12)
  ),
];

final AnnouncementProvider = StateNotifierProvider<AnnouncementNotifier, List<AnnouncementModel>> (
    (ref) => AnnouncementNotifier()
);

class AnnouncementNotifier extends StateNotifier<List<AnnouncementModel>> {
  AnnouncementNotifier() : super(dummyAnnouncement);
}