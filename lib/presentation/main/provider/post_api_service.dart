import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/network/api_endpoints.dart';
import 'package:falletter_mobile_v2/models/post_detail_model.dart';
import 'package:falletter_mobile_v2/models/post_model.dart';

class PostApiService {
  final Dio dio;

  PostApiService(this.dio);

  Future<List<PostModel>> getPostList() async {
    try {
      final response = await dio.get(ApiEndpoints.post);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List ? response.data : [];
        return data.map((json) => PostModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load posts');
    } catch(e) {
      throw Exception('Failed to load posts');
    }
  }

  Future<int> createPost({required String title, required String content}) async {
    try {
      final response = await dio.post(
          ApiEndpoints.post,
          data: {
            'title': title,
            'content': content
          }
      );

      if (response.statusCode == 201) {
        return response.data['communityId'] as int;
      }
      throw Exception('Failed to create post');
    } catch(e) {
      throw Exception('Failed to create post');
    }
  }

  Future<PostDetailModel> getDetailPost(int postId) async {
    try {
      final response = await dio.get('${ApiEndpoints.post}/$postId');

      if (response.statusCode == 200) {
        return PostDetailModel.fromJson(response.data);
      }
      throw Exception('Failed to load detail post');
    } catch(e) {
      throw Exception('Failed to load detail post');
    }
  }

  Future<void> editPost({
    required int postId,
    required String title,
    required String content
  }) async {
    try {
      final response = await dio.patch(
          '${ApiEndpoints.post}/$postId',
          data: {
            'title': title,
            'content': content
          }
      );

      if (response.statusCode == 200) return;
      throw Exception('Failed to edit post');
    } catch(e) {
      throw Exception('Failed to edit post');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final response = await dio.delete('${ApiEndpoints.post}/$postId');

      if (response.statusCode == 204) return;
      throw Exception('Failed to delete post');
    } catch(e) {
      throw Exception('Failed to delete post');
    }
  }

  Future<void> addComment({required int postId, required String comment}) async {
    try {
      final response = await dio.post(
          '${ApiEndpoints.comment}/$postId',
          data: {
            'comment': comment
          }
      );

      if (response.statusCode == 201) return;
      throw Exception('Failed to add comment');
    } catch(e) {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> deleteComment({required int commentId}) async {
    try {
      final response = await dio.delete(
        '${ApiEndpoints.comment}/$commentId',
      );

      if (response.statusCode == 204) return;
      throw Exception('Failed to delete comment');
    } catch(e) {
      throw Exception('Failed to delete comment');
    }
  }
}