import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field_label.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? initialValue;

  final TextStyle? style;

  final InputDecoration? decoration;

  final double labelSpacing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool expands;
  final bool? showCursor;

  final String obscuringCharacter;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final double? width;
  final double? height;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  bool get hasLabel =>
      decoration != null &&
      (decoration!.label != null || decoration!.labelText != null);

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.focusNode,
    this.initialValue,
    this.style,
    this.decoration = const InputDecoration(),
    this.labelSpacing = 8,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.expands = false,
    this.showCursor,
    this.obscuringCharacter = '*',
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.height = 44,
    this.width,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = FalletterTextStyle.placeholder
        .copyWith(color: FalletterColor.white)
        .merge(style);

    InputDecoration inputDecoration = InputDecoration(
      icon: decoration?.icon,
      iconColor: decoration?.iconColor,
      helper: decoration?.helper,
      helperText: decoration?.helperText,
      helperStyle: decoration?.helperStyle,
      helperMaxLines: decoration?.helperMaxLines,
      hintText: decoration?.hintText,
      hintStyle: decoration?.hintStyle,
      hintMaxLines: decoration?.hintMaxLines,
      hintTextDirection: decoration?.hintTextDirection,
      error: decoration?.error,
      errorText: decoration?.errorText,
      errorStyle: decoration?.errorStyle,
      errorMaxLines: decoration?.errorMaxLines,
      floatingLabelBehavior: decoration?.floatingLabelBehavior,
      floatingLabelAlignment: decoration?.floatingLabelAlignment,
      isCollapsed: decoration?.isCollapsed ?? false,
      isDense: decoration?.isDense,
      contentPadding: decoration?.contentPadding,
      prefixIcon: decoration?.prefixIcon,
      prefixIconColor: decoration?.prefixIconColor,
      prefixIconConstraints: decoration?.prefixIconConstraints,
      prefix: decoration?.prefix,
      prefixText: decoration?.prefixText,
      prefixStyle: decoration?.prefixStyle,
      suffixIcon: decoration?.suffixIcon,
      suffixIconColor: decoration?.suffixIconColor,
      suffixIconConstraints: decoration?.suffixIconConstraints,
      suffix: decoration?.suffix,
      suffixText: decoration?.suffixText,
      suffixStyle: decoration?.suffixStyle,
      counter: decoration?.counter,
      counterText: decoration?.counterText,
      counterStyle: decoration?.counterStyle,
      filled: decoration?.filled,
      fillColor: decoration?.fillColor,
      focusColor: decoration?.focusColor,
      hoverColor: decoration?.hoverColor,
      errorBorder: decoration?.errorBorder,
      focusedBorder: decoration?.focusedBorder,
      focusedErrorBorder: decoration?.focusedErrorBorder,
      disabledBorder: decoration?.disabledBorder,
      enabledBorder: decoration?.enabledBorder,
      enabled: decoration?.enabled ?? true,
      border: decoration?.border,
      semanticCounterText: decoration?.semanticCounterText,
      alignLabelWithHint: decoration?.alignLabelWithHint,
      constraints: decoration?.constraints,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel) ...[
          CustomTextFormFieldLabel(
            label: decoration!.label,
            labelText: decoration!.labelText,
            labelStyle: decoration!.labelStyle,
          ),
        ],
        TextFormField(
          autocorrect: autocorrect,
          showCursor: showCursor,
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode,
          decoration: inputDecoration,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: defaultTextStyle,
          textAlign: textAlign,
          autofocus: autofocus,
          readOnly: readOnly,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          onTapOutside: onTapOutside,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          validator: validator,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}
