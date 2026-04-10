import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/student_provider.dart';
import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAhead extends ConsumerWidget {
  final TextEditingController controller;
  final void Function() onChanged;
  final Function(StudentModel) onSelected;

  const TypeAhead({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentProvider);
    final userAsync = ref.watch(userInfoProvider);
    final count = ref.watch(letterProvider).count;
    final scrollController = ScrollController();
    return TypeAheadField<StudentModel>(
      controller: controller,
      constraints: BoxConstraints(maxHeight: 140),
      builder: (context, controller, focusNode) {
        return CustomTextFormField(
          onChanged: (value) {
           onChanged();
          },
          maxLength: 10,
          maxLines: 1,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            enabled: count > 0,
            hintText: '학번을 입력해주세요',
            counterText: '',
          ),
        );
      },
      listBuilder: (context, children) {
        return RawScrollbar(
          controller: scrollController,
          thumbColor: FalletterColor.gray500,
          thumbVisibility: true,
          thickness: 4,
          radius: Radius.circular(8),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: children,
          ),
        );
      },
      decorationBuilder: (context, child) {
        return Container(
          decoration: BoxDecoration(color: context.cardBg),
          child: child,
        );
      },
      itemBuilder: (BuildContext context, value) {
        final text = '${value.schoolNumber} ${value.name}';
        final inputText = controller.text;
        final stressText = text.indexOf(inputText);
        final baseStyle = FalletterTextStyle.body3;
        if (stressText >= 0) {
          return ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            title: Text.rich(
              TextSpan(
                style: baseStyle.copyWith(color: context.middleColor),
                children: [
                  TextSpan(text: text.substring(0, stressText)),
                  TextSpan(
                    text: text.substring(
                      stressText,
                      stressText + inputText.length,
                    ),
                    style: baseStyle.copyWith(color: context.textColor),
                  ),
                  TextSpan(
                    text: text.substring(stressText + inputText.length),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
      hideOnEmpty: true,
      onSelected: (value) {
        controller.text = '${value.schoolNumber} ${value.name}';
        onSelected(value);
      },
      suggestionsCallback: (input) async {
        if (input.isEmpty) {
          return <StudentModel>[];
        }
        return userAsync.when(
          data: (user) {
            return students.where((s) =>
            s.id != user.id &&
                (s.name.contains(input) || s.schoolNumber.contains(input)),
            ).toList();
          },
          loading: () => [],
          error: (_, __) => [],
        );
      },
    );
  }
}
