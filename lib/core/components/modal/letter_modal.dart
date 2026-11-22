import 'package:falletter_mobile_v2/core/components/modal/report_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class LetterModal extends ConsumerWidget {
  final String dear;
  final String content;
  final String bottom;
  final int? reportLetterId;

  const LetterModal({
    super.key,
    required this.dear,
    required this.content,
    required this.bottom,
    this.reportLetterId,
  });

  void _showReportDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ReportModal(
        title: '레터 신고',
        duplicateMessage: '이미 신고한 레터입니다.',
        onReport: (reason) async {},
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final closeButtonSize = MediaQuery.of(context).size.width * 0.13;
    const height = SizedBox(height: 12);
    final divider = Divider(color: FalletterColor.gray200, height: 1);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: themeColors.letterModalBorder,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.cardBg,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            dear,
                            style: FalletterTextStyle.body3.copyWith(
                              color: context.textColor,
                            ),
                          ),
                        ),
                        height,
                        divider,
                        height,
                        Center(
                          child: Text(
                            content,
                            style: FalletterTextStyle.body3.copyWith(
                              color: context.textColor,
                            ),
                          ),
                        ),
                        height,
                        divider,
                        height,
                        Center(
                          child: Text(
                            bottom,
                            style: FalletterTextStyle.body3.copyWith(
                              color: context.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (reportLetterId != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          position: PopupMenuPosition.under,
                          color: FalletterColor.gray50,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          icon: Icon(
                            Symbols.more_vert,
                            size: 24,
                            color: context.isDarkMode
                                ? FalletterColor.gray700
                                : FalletterColor.gray100,
                          ),
                          onSelected: (value) {
                            if (value == 'report') {
                              _showReportDialog(context);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: 'report',
                              child: Center(
                                child: Text(
                                  '신고',
                                  style: FalletterTextStyle.body2.copyWith(
                                    color: FalletterColor.error,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: closeButtonSize,
                height: closeButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.bgColor,
                ),
                child: Icon(
                  Symbols.close,
                  color: context.textColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
