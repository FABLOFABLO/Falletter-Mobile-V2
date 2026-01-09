import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/cupertino.dart';

class SelectText extends StatelessWidget {
  final String title;
  const SelectText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,style: FalletterTextStyle.title2,);
  }
}
