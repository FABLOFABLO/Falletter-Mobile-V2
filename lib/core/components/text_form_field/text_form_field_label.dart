import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldLabel extends StatelessWidget {
  final Widget? label;
  final String? labelText;
  final TextStyle? labelStyle;

  const CustomTextFormFieldLabel({
    super.key,
    this.label,
    this.labelText,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = FalletterTextStyle.label;
    return DefaultTextStyle(
      style: defaultTextStyle.merge(labelStyle),
      child: Row(children: [label ?? Text(labelText!)]),
    );
  }
}
