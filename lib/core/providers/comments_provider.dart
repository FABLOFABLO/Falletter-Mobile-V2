// import 'package:falletter_mobile_v2/models/post_detail_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final dummyPosts = [
//   PostDetailModel(
//       id: 1,
//       title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
//       content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
//       author: Author(name: '네모의 꿈', userId: 1),
//       createdAt: DateTime(2025, 3, 24),
//       updatedAt: DateTime(2025, 3, 25),
//       comment: [
//         Comment(
//             commentId: 1,
//             user: Author(userId: 1, name: '홍길동'),
//             comment: '안녕하세요',
//             createdAt: DateTime(2025, 3, 24),
//             updatedAt: DateTime(2025, 3, 25)
//         )
//       ]
//   ),
//   PostDetailModel(
//       id: 2,
//       title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
//       content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
//       author: Author(name: '네모의 꿈', userId: 2),
//       createdAt: DateTime(2025, 3, 24),
//       updatedAt: DateTime(2025, 3, 25),
//       comment: [
//         Comment(
//             commentId: 2,
//             user: Author(userId: 2, name: '홍길동'),
//             comment: '안녕하세요',
//             createdAt: DateTime(2025, 3, 24),
//             updatedAt: DateTime(2025, 3, 25)
//         )
//       ]
//   ),
//   PostDetailModel(
//       id: 3,
//       title: '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
//       content: '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
//       author: Author(name: '네모의 꿈', userId: 3),
//       createdAt: DateTime(2025, 3, 24),
//       updatedAt: DateTime(2025, 3, 25),
//       comment: [
//         Comment(
//             commentId: 3,
//             user: Author(userId: 3, name: '홍길동'),
//             comment: '안녕하세요',
//             createdAt: DateTime(2025, 3, 24),
//             updatedAt: DateTime(2025, 3, 25)
//         )
//       ]
//   ),
// ];
//
// final commentsProvider = StateNotifierProvider<CommentsNotifier, List<PostDetailModel>>(
//     (ref) => CommentsNotifier()
// );
//
// class CommentsNotifier extends StateNotifier<List<PostDetailModel>> {
//   CommentsNotifier() : super(dummyPosts);
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsProvider =
    StateNotifierProvider<CommentsNotifier, Map<int, List<int>>>(
      (ref) => CommentsNotifier(),
    );

class CommentsNotifier extends StateNotifier<Map<int, List<int>>> {
  CommentsNotifier()
    : super({
        1: [1, 2, 3],
        2: [4],
        3: [],
      });

  int commentCount(int postId) {
    return state[postId]?.length ?? 0;
  }
}
