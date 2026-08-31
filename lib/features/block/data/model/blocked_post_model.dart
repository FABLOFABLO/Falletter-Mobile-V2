class BlockedPostModel {
  final int blockId;
  final int postId;
  final String title;
  final String content;
  final String anonymousNickname;
  final DateTime blockedAt;

  BlockedPostModel({
    required this.blockId,
    required this.postId,
    required this.title,
    required this.content,
    required this.anonymousNickname,
    required this.blockedAt,
  });

  factory BlockedPostModel.fromJson(Map<String, dynamic> json) {
    return BlockedPostModel(
      blockId: json['blockId'],
      postId: json['postId'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      anonymousNickname: json['anonymousNickname'] ?? '',
      blockedAt: DateTime.parse(json['blockedAt']),
    );
  }
}
