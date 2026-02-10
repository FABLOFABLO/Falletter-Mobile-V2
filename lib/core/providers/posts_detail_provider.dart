import 'package:falletter_mobile_v2/core/utils/random_nickname.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/models/post_detail_model.dart';

final dummyDetailPosts = PostDetailModel(
      id: 1,
      title: '내일 1학년 1반 시간표 바뀌었다는데 아시는 분?? 내일 1학년 1반 시간표 바뀌었다는데 아시는 분??',
      content: '시간표 바뀐 거 아시는 분 댓글 달아주세요ㅠㅠ 시간표 바뀐 거 아시는 분 댓글 달아주세요ㅠㅠ 시간표 바뀐 거 아시는 분 댓글 달아주세요ㅠㅠ 시간표 바뀐 거 아시는 분 댓글 달아주세요ㅠㅠ ',
      author: Author(userId: 1, name: getNickname(1)),
      createdAt: DateTime(2025, 3, 24),
      updatedAt: DateTime(2025, 3, 25),
      comment: [
        Comment(
            commentId: 1,
            user: Author(userId: 2, name: getNickname(1)),
            comment: '1교시가 국어로 변경되었습니다. 1교시가 국어로 변경되었습니다.',
            createdAt: DateTime(2025, 7, 9),
            updatedAt: DateTime(2025, 7, 10)
        ),
        Comment(
            commentId: 2,
            user: Author(userId: 3, name: getNickname(2)),
            comment: '2교시는 수학으로 변경됩니다.',
            createdAt: DateTime(2020, 2, 23),
            updatedAt: DateTime(2026, 1, 6)
        )
      ]
  );

final postsDetailProvider = StateNotifierProvider<PostsDetailNotifier, PostDetailModel>(
    (ref) => PostsDetailNotifier()
);

class PostsDetailNotifier extends StateNotifier<PostDetailModel> {
  PostsDetailNotifier() : super(dummyDetailPosts);
}