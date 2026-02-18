import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/models/announcement_detail_model.dart';

final dummyDetailAnnouncement = AnnouncementDetailModel(
    id: 1,
    title: '공지 제목입니다. 공지 제목입니다.',
    content: '공지 내용입니다. 공지 내용입니다. 공지 내용입니다. 공지 내용입니다.공지 내용입니다. 공지 내용입니다. 공지 내용입니다. 공지 내용입니다.',
    authorName: '관리자',
    createdAt: DateTime(2020, 4, 18)
);

final AnnouncementDetailProvider = StateNotifierProvider<AnnouncementDetailNotifier, AnnouncementDetailModel>(
    (ref) => AnnouncementDetailNotifier()
);

class AnnouncementDetailNotifier extends StateNotifier<AnnouncementDetailModel> {
  AnnouncementDetailNotifier() : super(dummyDetailAnnouncement);
}