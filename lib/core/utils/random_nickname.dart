import 'dart:math';
import 'package:falletter_mobile_v2/core/constants/anonymous_nicknames.dart';

String getNickname(int id) {
  final random = Random(id);
  return anonymousNicknames[random.nextInt(anonymousNicknames.length)];
}