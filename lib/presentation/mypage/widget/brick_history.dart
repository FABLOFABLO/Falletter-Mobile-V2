import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrickHistory extends ConsumerWidget {
  final String title;
  final int brick;
  final String question;
  final DateTime time;

  const BrickHistory({
    super.key,
    required this.title,
    required this.brick,
    required this.question,
    required this.time,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final highStyle = FalletterTextStyle.subTitle2;
    final rowStyle = FalletterTextStyle.body4;
    final color = FalletterColor.gray500;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.cardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: highStyle),
              brick > 0
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return FalletterGradient.horizontal(
                          themeColors.text.colors,
                        ).createShader(bounds);
                      },
                      child: Text(
                        '+$brick',
                        style: highStyle.copyWith(color: context.textColor),
                      ),
                    )
                  : Text(
                      '$brick',
                      style: highStyle.copyWith(color: FalletterColor.error),
                    ),
            ],
          ),
          if (question.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(question, style: rowStyle.copyWith(color: color)),
          ],
          const SizedBox(height: 4),
          Text(brickTime(time), style: rowStyle.copyWith(color: color)),
        ],
      ),
    );
  }
}
