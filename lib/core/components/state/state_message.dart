import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

Widget stateMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: FalletterTextStyle.body2.copyWith(color: FalletterColor.gray500),
      ),
    ),
  );
}

class StateMessages {
  StateMessages._();

  static const loadFailed = '불러오지 못했어요.\n잠시 후 다시 시도해주세요.';
}
