import 'package:falletter_mobile_v2/core/utils/time_utils.dart';

class NoticeItem {
  final int id;
  final String schoolNumber;
  final String name;
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
    required this.name,
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
      schoolNumber: json['schoolNumber'] ?? json['school_number'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      question: json['question'] ?? '',
      emoji: json['emoji'] ?? '',
      questionId: json['questionId'] ?? json['question_id'] ?? 0,
      targetUserId: json['targetUserId'] ?? json['target_user_id'] ?? 0,
      writerUserId: json['writerUserId'] ?? json['writer_user_id'] ?? 0,
      createdAt: DateTime.parse(
        json['createdAt'] ??
            json['created_at'] ??
            DateTime.now().toIso8601String(),
      ),
      isRead: json['isRead'] ?? json['is_read'] ?? false,
    );
  }

  String get gradeGenderLabel {
    final grade = schoolNumber.isNotEmpty ? schoolNumber[0] : '?';
    final genderLabel = gender == 'FEMALE' ? '여학생' : '남학생';
    return '${grade}학년 ${genderLabel}의 선택';
  }

  String get timeAgo {
    return timeCheck(createdAt);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolNumber': schoolNumber,
      'name': name,
      'gender': gender,
      'question': question,
      'emoji': emoji,
      'questionId': questionId,
      'targetUserId': targetUserId,
      'writerUserId': writerUserId,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  NoticeItem copyWith({
    int? id,
    String? schoolNumber,
    String? name,
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
      name: name ?? this.name,
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

class HintData {
  final int id;
  final String firstHint;
  final String secondHint;
  final String thirdHint;
  final int userId;

  HintData({
    required this.id,
    required this.firstHint,
    required this.secondHint,
    required this.thirdHint,
    required this.userId,
  });

  factory HintData.fromJson(Map<String, dynamic> json) {
    return HintData(
      id: json['id'] ?? 0,
      firstHint: json['firstHint'] ?? json['first_hint'] ?? '',
      secondHint: json['secondHint'] ?? json['second_hint'] ?? '',
      thirdHint: json['thirdHint'] ?? json['third_hint'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstHint': firstHint,
      'secondHint': secondHint,
      'thirdHint': thirdHint,
      'userId': userId,
    };
  }

  String? hintAt(int index) {
    switch (index) {
      case 0:
        return firstHint.isNotEmpty ? firstHint : null;
      case 1:
        return secondHint.isNotEmpty ? secondHint : null;
      case 2:
        return thirdHint.isNotEmpty ? thirdHint : null;
      default:
        return null;
    }
  }

  int get unlockedCount {
    int count = 0;
    if (firstHint.isNotEmpty) count++;
    if (secondHint.isNotEmpty) count++;
    if (thirdHint.isNotEmpty) count++;
    return count;
  }

  List<int> get unlockedHints {
    final List<int> unlocked = [];
    if (firstHint.isNotEmpty) unlocked.add(0);
    if (secondHint.isNotEmpty) unlocked.add(1);
    if (thirdHint.isNotEmpty) unlocked.add(2);
    return unlocked;
  }

  bool get allUnlocked => unlockedCount >= 3;

  HintData copyWith({
    int? id,
    String? firstHint,
    String? secondHint,
    String? thirdHint,
    int? userId,
  }) {
    return HintData(
      id: id ?? this.id,
      firstHint: firstHint ?? this.firstHint,
      secondHint: secondHint ?? this.secondHint,
      thirdHint: thirdHint ?? this.thirdHint,
      userId: userId ?? this.userId,
    );
  }
}

class NoticeDetail {
  final int id;
  final String schoolNumber;
  final String name;
  final String gender;
  final String question;
  final String emoji;
  final int questionId;
  final int targetUserId;
  final int writerUserId;
  final DateTime createdAt;
  final HintData? hintData;

  NoticeDetail({
    required this.id,
    required this.schoolNumber,
    required this.name,
    required this.gender,
    required this.question,
    required this.emoji,
    required this.questionId,
    required this.targetUserId,
    required this.writerUserId,
    required this.createdAt,
    this.hintData,
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> json) {
    HintData? hint;
    if (json['hint'] != null) {
      hint = HintData.fromJson(json['hint']);
    }

    return NoticeDetail(
      id: json['id'] ?? 0,
      schoolNumber: json['schoolNumber'] ?? json['school_number'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      question: json['question'] ?? '',
      emoji: json['emoji'] ?? '',
      questionId: json['questionId'] ?? json['question_id'] ?? 0,
      targetUserId: json['targetUserId'] ?? json['target_user_id'] ?? 0,
      writerUserId: json['writerUserId'] ?? json['writer_user_id'] ?? 0,
      createdAt: DateTime.parse(
        json['createdAt'] ??
            json['created_at'] ??
            DateTime.now().toIso8601String(),
      ),
      hintData: hint,
    );
  }

  factory NoticeDetail.fromNoticeItem(NoticeItem item) {
    return NoticeDetail(
      id: item.id,
      schoolNumber: item.schoolNumber,
      name: item.name,
      gender: item.gender,
      question: item.question,
      emoji: item.emoji,
      questionId: item.questionId,
      targetUserId: item.targetUserId,
      writerUserId: item.writerUserId,
      createdAt: item.createdAt,
    );
  }

  String get gradeGenderLabel {
    final grade = schoolNumber.isNotEmpty ? schoolNumber[0] : '?';
    final genderLabel = gender == 'FEMALE' ? '여학생' : '남학생';
    return '${grade}학년 ${genderLabel}의 선택';
  }

  int get totalHints => 3;

  List<int> get unlockedHints => hintData?.unlockedHints ?? [];

  bool get allUnlocked => hintData?.allUnlocked ?? false;

  String? hintAt(int index) => hintData?.hintAt(index);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolNumber': schoolNumber,
      'name': name,
      'gender': gender,
      'question': question,
      'emoji': emoji,
      'questionId': questionId,
      'targetUserId': targetUserId,
      'writerUserId': writerUserId,
      'createdAt': createdAt.toIso8601String(),
      'hint': hintData?.toJson(),
    };
  }

  NoticeDetail copyWith({
    int? id,
    String? schoolNumber,
    String? name,
    String? gender,
    String? question,
    String? emoji,
    int? questionId,
    int? targetUserId,
    int? writerUserId,
    DateTime? createdAt,
    HintData? hintData,
  }) {
    return NoticeDetail(
      id: id ?? this.id,
      schoolNumber: schoolNumber ?? this.schoolNumber,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      question: question ?? this.question,
      emoji: emoji ?? this.emoji,
      questionId: questionId ?? this.questionId,
      targetUserId: targetUserId ?? this.targetUserId,
      writerUserId: writerUserId ?? this.writerUserId,
      createdAt: createdAt ?? this.createdAt,
      hintData: hintData ?? this.hintData,
    );
  }
}
