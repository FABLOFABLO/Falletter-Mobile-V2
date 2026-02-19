import 'package:falletter_mobile_v2/models/send_letter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendLetterDummy = [
  SendLetterModel(
    id: 1,
    content:
        '안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고,안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고,안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고,안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고,',
    receptionId: 1,
    senderId: 1,
    isDelivered: true,
    isPassed: true,
    createdAt: DateTime.now(),
  ),
  SendLetterModel(
    id: 2,
    content: '안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고',
    receptionId: 2,
    senderId: 2,
    isDelivered: true,
    isPassed: true,
    createdAt: DateTime.now(),
  ),
  SendLetterModel(
    id: 3,
    content: '안녕하세요 선배님! 저는 1학년 1반 강해민입니다. 저는 현재 관심있는 분야가 있고',
    receptionId: 3,
    senderId: 3,
    isDelivered: true,
    isPassed: true,
    createdAt: DateTime.now(),
  ),
];

final sendLetterProvider =
    StateNotifierProvider<SendLetterNotifier, List<SendLetterModel>>(
      (ref) => SendLetterNotifier(),
    );

class SendLetterNotifier extends StateNotifier<List<SendLetterModel>> {
  SendLetterNotifier() : super(sendLetterDummy);
}
