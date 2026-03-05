class NoticeItem {
  final int id;
  final String schoolNumber;
  final String gender;
  final String question;
  final String emoji;
  final int questionId;
  final int targetUserId;
  final int writerUserId;
  final DateTime createdAt;
  final bool isRead;

  NoticeItem({
    required this.id,
    required this.schoolNumber,
    required this.gender,
    required this.question,
    required this.emoji,
    required this.questionId,
    required this.targetUserId,
    required this.writerUserId,
    required this.createdAt,
    this.isRead = false,
  });

  factory NoticeItem.fromJson(Map<String, dynamic> json) {
    return NoticeItem(
      id: json['id'] ?? 0,
      schoolNumber: json['school_number'] ?? '',
      gender: json['gender'] ?? '',
      question: json['question'] ?? '',
      emoji: json['emoji'] ?? '',
      questionId: json['question_id'] ?? 0,
      targetUserId: json['target_user_id'] ?? 0,
      writerUserId: json['writer_user_id'] ?? 0,
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      isRead: json['is_read'] ?? false,
    );
  }

  String get gradeGenderLabel {
    final grade = schoolNumber.isNotEmpty ? schoolNumber[0] : '?';
    final genderLabel = gender == 'FEMALE' ? '여학생' : '남학생';
    return '${grade}학년 ${genderLabel}의 선택';
  }

  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 7) return '${diff.inDays}일 전';
    return '${createdAt.month}/${createdAt.day}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_number': schoolNumber,
      'gender': gender,
      'question': question,
      'emoji': emoji,
      'question_id': questionId,
      'target_user_id': targetUserId,
      'writer_user_id': writerUserId,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
    };
  }

  NoticeItem copyWith({
    int? id,
    String? schoolNumber,
    String? gender,
    String? question,
    String? emoji,
    int? questionId,
    int? targetUserId,
    int? writerUserId,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NoticeItem(
      id: id ?? this.id,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      gender: gender ?? this.gender,
      question: question ?? this.question,
      emoji: emoji ?? this.emoji,
      questionId: questionId ?? this.questionId,
      targetUserId: targetUserId ?? this.targetUserId,
      writerUserId: writerUserId ?? this.writerUserId,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NoticeDetail {
  final int id;
  final String schoolNumber;
  final String gender;
  final String question;
  final String emoji;
  final int questionId;
  final int targetUserId;
  final int writerUserId;
  final DateTime createdAt;

  final String? firstHint;
  final String? secondHint;
  final String? thirdHint;
  final List<int> unlockedHints;

  NoticeDetail({
    required this.id,
    required this.schoolNumber,
    required this.gender,
    required this.question,
    required this.emoji,
    required this.questionId,
    required this.targetUserId,
    required this.writerUserId,
    required this.createdAt,
    this.firstHint,
    this.secondHint,
    this.thirdHint,
    this.unlockedHints = const [],
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> json) {
    final hintData = json['hint'] as Map<String, dynamic>?;

    return NoticeDetail(
      id: json['id'] ?? 0,
      schoolNumber: json['school_number'] ?? '',
      gender: json['gender'] ?? '',
      question: json['question'] ?? '',
      emoji: json['emoji'] ?? '',
      questionId: json['question_id'] ?? 0,
      targetUserId: json['target_user_id'] ?? 0,
      writerUserId: json['writer_user_id'] ?? 0,
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      firstHint: hintData?['first_hint'] ?? json['first_hint'],
      secondHint: hintData?['second_hint'] ?? json['second_hint'],
      thirdHint: hintData?['third_hint'] ?? json['third_hint'],
      unlockedHints:
          (json['unlocked_hints'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }

  String get gradeGenderLabel {
    final grade = schoolNumber.isNotEmpty ? schoolNumber[0] : '?';
    final genderLabel = gender == 'FEMALE' ? '여학생' : '남학생';
    return '${grade}학년 ${genderLabel}의 선택';
  }

  int get totalHints => 3;

  String? hintAt(int index) {
    switch (index) {
      case 0:
        return firstHint;
      case 1:
        return secondHint;
      case 2:
        return thirdHint;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_number': schoolNumber,
      'gender': gender,
      'question': question,
      'emoji': emoji,
      'question_id': questionId,
      'target_user_id': targetUserId,
      'writer_user_id': writerUserId,
      'created_at': createdAt.toIso8601String(),
      'first_hint': firstHint,
      'second_hint': secondHint,
      'third_hint': thirdHint,
      'unlocked_hints': unlockedHints,
    };
  }

  NoticeDetail copyWith({
    int? id,
    String? schoolNumber,
    String? gender,
    String? question,
    String? emoji,
    int? questionId,
    int? targetUserId,
    int? writerUserId,
    DateTime? createdAt,
    String? firstHint,
    String? secondHint,
    String? thirdHint,
    List<int>? unlockedHints,
  }) {
    return NoticeDetail(
      id: id ?? this.id,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      gender: gender ?? this.gender,
      question: question ?? this.question,
      emoji: emoji ?? this.emoji,
      questionId: questionId ?? this.questionId,
      targetUserId: targetUserId ?? this.targetUserId,
      writerUserId: writerUserId ?? this.writerUserId,
      createdAt: createdAt ?? this.createdAt,
      firstHint: firstHint ?? this.firstHint,
      secondHint: secondHint ?? this.secondHint,
      thirdHint: thirdHint ?? this.thirdHint,
      unlockedHints: unlockedHints ?? this.unlockedHints,
    );
  }
}
