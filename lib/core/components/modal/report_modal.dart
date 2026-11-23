import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ReportModal extends ConsumerStatefulWidget {
  final String title;
  final String duplicateMessage;
  final Future<void> Function(String reason) onReport;

  const ReportModal({
    super.key,
    required this.title,
    required this.duplicateMessage,
    required this.onReport,
  });

  @override
  ConsumerState<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends ConsumerState<ReportModal> {
  final TextEditingController _reportController = TextEditingController();
  final baseInfoStyle = FalletterTextStyle.body3;
  final maxLength = 200;

  bool _isSubmitting = false;

  @override
  void initState() {
    _reportController.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
  }

  bool get isReportEnabled => _reportController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: context.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: FalletterTextStyle.subTitle2.copyWith(
                      color: context.textColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.of(context).pop();
                      _reportController.clear();
                    },
                    icon: Icon(
                      Symbols.close,
                      color: FalletterColor.gray200,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text(
                      '사유 입력',
                      style: FalletterTextStyle.body2.copyWith(
                        color: context.subTextColor,
                      ),
                    ),
                    Spacer(),
                    ListenableBuilder(
                      listenable: _reportController,
                      builder: (context, child) => Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${_reportController.text.length}',
                              style: baseInfoStyle.copyWith(
                                color: context.textColor,
                              ),
                            ),
                            TextSpan(
                              text: '/$maxLength',
                              style: baseInfoStyle.copyWith(
                                color: FalletterColor.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomTextFormField(
                  maxLength: maxLength,
                  controller: _reportController,
                  decoration: InputDecoration(
                    hintText: '신고 사유를 입력해주세요.',
                    counterText: '',
                  ),
                  maxLines: ((MediaQuery.sizeOf(context).height -
                              MediaQuery.viewInsetsOf(context).bottom -
                              340) /
                          26)
                      .floor()
                      .clamp(1, 12),
                ),
              ),
              ListenableBuilder(
                listenable: _reportController,
                builder: (context, child) => GestureDetector(
                  onTap: isReportEnabled
                      ? () async {
                          if (_isSubmitting) return;
                          _isSubmitting = true;
                          try {
                            await widget.onReport(_reportController.text.trim());
                            if (!context.mounted) return;
                            successSnackBar(context, '신고가 접수되었습니다.');
                            Navigator.of(context).pop();
                            _reportController.clear();
                          } on DioException catch (e) {
                            if (!context.mounted) return;
                            errorSnackBar(
                              context,
                              e.response?.statusCode == 409
                                  ? widget.duplicateMessage
                                  : '신고에 실패했습니다.',
                            );
                            Navigator.of(context).pop();
                            _reportController.clear();
                          } finally {
                            _isSubmitting = false;
                          }
                        }
                      : null,
                  child: Container(
                    width: 350,
                    height: 52,
                    decoration: BoxDecoration(
                      color: isReportEnabled
                          ? FalletterColor.error
                          : context.disabledFillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '신고',
                        style: FalletterTextStyle.subTitle2.copyWith(
                          color: FalletterColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
