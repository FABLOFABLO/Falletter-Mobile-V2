import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/post_api_service.dart';
import 'package:falletter_mobile_v2/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postApiServiceProvider = Provider<PostApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
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
      throw Exception('Failed to load posts');
    }
  }

  Future<int?> addPost(String title, String content) async {
    try {
      final postId = await apiService.createPost(title: title, content: content);
      await loadPosts();
      return postId;
    } catch(e) {
      throw Exception('Failed to add post');
    }
  }
}