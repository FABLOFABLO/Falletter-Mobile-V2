import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/student_provider.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAhead extends ConsumerWidget {
  final TextEditingController controller;
  final void Function() onChanged;
  final Function(String) onSelected;

  const TypeAhead({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(letterProvider).count;
    final scrollController = ScrollController();
    return TypeAheadField<String>(
      controller: controller,
      constraints: BoxConstraints(maxHeight: 140),
      builder: (context, controller, focusNode) {
        return CustomTextFormField(
          onChanged: (value) {
           onChanged;
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
        final inputText = controller.text;
        final stressText = value.indexOf(inputText);
        final baseStyle = FalletterTextStyle.body3;
        if (stressText >= 0) {
          return ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            title: Text.rich(
              TextSpan(
                style: baseStyle.copyWith(color: context.middleColor),
                children: [
                  TextSpan(text: value.substring(0, stressText)),
                  TextSpan(
                    text: value.substring(
                      stressText,
                      stressText + inputText.length,
                    ),
                    style: baseStyle.copyWith(color: context.textColor),
                  ),
                  TextSpan(
                    text: value.substring(stressText + inputText.length),
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
        controller.text = value;
        onSelected(value);
      },
      suggestionsCallback: (student) async {
        if (student.isEmpty) {
          return <String>[];
        }
        final students = ref.read(studentProvider);
        return students
            .where(
              (students) =>
                  students.name.contains(student) ||
                  students.schoolNumber.contains(student),
            )
            .map((e) => '${e.schoolNumber} ${e.name}')
            .toList();
      },
    );
  }
}
