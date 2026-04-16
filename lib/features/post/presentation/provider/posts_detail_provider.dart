import 'package:falletter_mobile_v2/core/network/dio.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/posts_provider.dart';
import 'package:falletter_mobile_v2/features/post/data/api/post_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/features/post/data/model/post_detail_model.dart';

final postRepositoryProvider = Provider<PostApiService>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return PostApiService(dio);
});

final postsDetailProvider = StateNotifierProvider<PostsDetailNotifier, PostDetailModel?>(
    (ref) {
      final apiService = ref.read(postRepositoryProvider);
      return PostsDetailNotifier(ref, apiService);
    }
);

class PostsDetailNotifier extends StateNotifier<PostDetailModel?> {
  final PostApiService apiService;
  final Ref ref;

  PostsDetailNotifier(this.ref, this.apiService) : super(null);

  Future<void> loadDetailPost(int postId) async {
    try {
      final post = await apiService.getDetailPost(postId);
      state = post;
    } catch(e) {
      throw Exception('게시글 상세 조회를 실패했습니다.');
    }
  }

  Future<void> editPost(int postId, String title, String content) async {
    try {
      await apiService.editPost(postId: postId, title: title, content: content);
      await loadDetailPost(postId);
      ref.read(postsProvider.notifier).loadPosts();
    } catch(e) {
      throw Exception('게시글 수정에 실패했습니다.');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await apiService.deletePost(postId);
      ref.read(postsProvider.notifier).loadPosts();
    } catch(e) {
      throw Exception('게시글 삭제에 실패했습니다.');
    }
  }

  Future<void> addComment(int postId, String comment) async {
    try {
      await apiService.addComment(
          postId: postId,
          comment: comment
      );
      await loadDetailPost(postId);
      ref.read(postsProvider.notifier).loadPosts();
    } catch(e) {
      throw Exception('댓글 작성에 실패했습니다.');
    }
  }

  Future<void> deleteComment(int commentId, int postId) async {
    try {
      await apiService.deleteComment(
          commentId: commentId
      );
      await loadDetailPost(postId);
      ref.read(postsProvider.notifier).loadPosts();
    } catch(e) {
      throw Exception('댓글 삭제에 실패했습니다.');
    }
  }
}