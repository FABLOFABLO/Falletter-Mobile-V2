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
