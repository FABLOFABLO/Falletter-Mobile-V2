String timeCheck(DateTime date) {
  final diff = DateTime.now().difference(date);
  print(DateTime.now());

  if (diff.inMinutes < 1) return '방금 전';
  if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
  if (diff.inHours < 24) return '${diff.inHours}시간 전';
  if (diff.inDays < 7) return '${diff.inDays}일 전';
  if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}주 전';
  return '${(diff.inDays / 30).floor()}개월 전';
}