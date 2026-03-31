import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/announcement_detail_model.dart';
import 'package:falletter_mobile_v2/models/announcement_model.dart';

class AnnouncementApiService {
  final Dio dio;

  AnnouncementApiService(this.dio);

  Future<List<AnnouncementModel>> getNoticeList() async {
    try {
      final response = await dio.get(ApiEndpoints.announcement);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => AnnouncementModel.fromJson(json)).toList();
      }
      throw Exception('공지 목록 조회 실패');
    } catch (e) {
      throw Exception('공지 목록 조회 실패');
    }
  }

  Future<AnnouncementDetailModel> getNotice(int announcementId) async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.announcement}/$announcementId',
      );

      if (response.statusCode == 200) {
        return AnnouncementDetailModel.fromJson(response.data);
      }
      throw Exception('공지사항 조회 실패');
    } catch (e) {
      throw Exception('공지사항 조회 실패');
    }
  }
}
