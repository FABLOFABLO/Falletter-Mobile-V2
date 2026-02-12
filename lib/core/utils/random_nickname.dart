import 'dart:math';
import 'package:falletter_mobile_v2/core/constants/anonymous_nicknames.dart';

String getNickname(int postId) {
  final random = Random(postId);
  return anonymousNicknames[random.nextInt(anonymousNicknames.length)];
}