String getLetterFormatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inDays >= 31) {
    return '${(diff.inDays / 30).floor()}달 전에 도착함';
  } else if (diff.inHours >= 24) {
    return '${(diff.inDays)}일 전에 도착함';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours}시간 전에 도착함';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes}분 전에 도착함';
  } else if (diff.inSeconds > 0) {
    return '방금 전';
  } else {
    return '전송 중';
  }
}

String sendLetterFormatTime(DateTime dateTime) {
  return '${dateTime.month}월 ${dateTime.day}일 도착';
}
