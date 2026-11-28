import 'package:falletter_mobile_v2/core/components/modal/report_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/report_provider.dart';
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

  void _showReportMenu(BuildContext context, WidgetRef ref) {
    final box = context.findRenderObject() as RenderBox;
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero, ancestor: overlayBox);
    final screenSize = overlayBox.size;
    final popupColor =
        context.isDarkMode ? FalletterColor.gray900 : FalletterColor.whiteBg;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (menuContext) => Stack(
        children: [
          Positioned(
            right: screenSize.width - offset.dx - box.size.width,
            top: offset.dy + box.size.height,
            child: Material(
              color: popupColor,
              elevation: 0,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () {
                  Navigator.of(menuContext).pop();
                  _showReportDialog(context, ref);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17.5,
                    vertical: 12,
                  ),
                  child: Text(
                    '신고',
                    style: FalletterTextStyle.body2.copyWith(
                      color: FalletterColor.error,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ReportModal(
        title: '레터 신고',
        duplicateMessage: '이미 신고한 레터입니다.',
        onReport: (reason) =>
            ref.read(reportProvider.notifier).addLetterReport(
                  reportLetterId!,
                  reason,
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final closeButtonSize = MediaQuery.of(context).size.width * 0.13;
    const height = SizedBox(height: 12);
    final divider = Divider(color: context.borderColor, height: 1);

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
                  color: context.isDarkMode ? context.cardBg : FalletterColor.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        if (reportLetterId != null) const SizedBox(width: 24),
                        Expanded(
                          child: Center(
                            child: Text(
                              dear,
                              style: FalletterTextStyle.body3.copyWith(
                                color: context.textColor,
                              ),
                            ),
                          ),
                        ),
                        if (reportLetterId != null)
                          Builder(
                            builder: (context) => GestureDetector(
                              onTap: () => _showReportMenu(context, ref),
                              child: Icon(
                                Symbols.more_vert,
                                size: 24,
                                color: context.borderColor,
                              ),
                            ),
                          ),
                      ],
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
