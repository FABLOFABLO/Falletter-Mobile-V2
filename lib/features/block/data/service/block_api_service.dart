import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/features/block/data/model/blocked_post_model.dart';

class BlockApiService {
  final Dio dio;

  BlockApiService(this.dio);

  Future<void> blockByPost(int postId) async {
    await dio.post(ApiEndpoints.userBlockByPost(postId));
  }

  Future<List<BlockedPostModel>> getBlockedPosts() async {
    final response = await dio.get(ApiEndpoints.userBlockList);
    final list = response.data as List;
    return list
        .map((e) => BlockedPostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> unblock(int blockId) async {
    await dio.delete(ApiEndpoints.userBlock(blockId));
  }
}
