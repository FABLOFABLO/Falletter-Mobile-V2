import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/post/data/service/post_api_service.dart';
import 'package:falletter_mobile_v2/features/post/data/model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postApiServiceProvider = Provider<PostApiService>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return PostApiService(dio);
});

final postsProvider = StateNotifierProvider<PostsNotifier, List<PostModel>>((ref) {
  final apiService = ref.read(postApiServiceProvider);
  return PostsNotifier(apiService);
});

class PostsNotifier extends StateNotifier<List<PostModel>> {
  final PostApiService apiService;

  PostsNotifier(this.apiService) : super([]);

  Future<void> loadPosts() async {
    try {
      final posts = await apiService.getPostList();
      state = posts;
    } catch (e) {
      throw Exception('게시글 목록 불러오기에 실패했습니다.');
    }
  }

  Future<int?> addPost(String title, String content) async {
    try {
      final postId = await apiService.createPost(title: title, content: content);
      await loadPosts();
      return postId;
    } catch(e) {
      throw Exception('게시글 등록에 실패했습니다.');
    }
  }
}