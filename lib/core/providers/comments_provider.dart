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

  void addComment(int postId, int commentId) {
    final current = state[postId] ?? [];
    state = {...state, postId: [...current, commentId]};
  }

  void deleteComment(int postId, int commentId) {
    final current = state[postId] ?? [];
    state = {...state, postId: current.where((commentIdList) => commentIdList != commentId).toList()};
  }

  int commentCount(int postId) {
    return state[postId]?.length ?? 0;
  }
}