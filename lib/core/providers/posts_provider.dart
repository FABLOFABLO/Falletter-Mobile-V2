import 'package:falletter_mobile_v2/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dummyPosts = [
  PostModel(
    id: 1,
    title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
    content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
    author: PostAuthor(name: '네모의 꿈'),
    createdAt: DateTime(2025, 3, 24),
    updatedAt: DateTime(2025, 3, 25)
  ),
  PostModel(
      id: 2,
      title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
      content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
      author: PostAuthor(name: '네모의 꿈'),
      createdAt: DateTime(2025, 3, 24),
      updatedAt: DateTime(2025, 3, 25)
  ),
  PostModel(
      id: 3,
      title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
      content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
      author: PostAuthor(name: '네모의 꿈'),
      createdAt: DateTime(2025, 3, 24),
      updatedAt: DateTime(2025, 3, 25)
  ),
];

final postsProvider = StateNotifierProvider<PostsNotifier, List<PostModel>>(
      (ref) => PostsNotifier(),
);

class PostsNotifier extends StateNotifier<List<PostModel>> {
  PostsNotifier() : super(dummyPosts);
}