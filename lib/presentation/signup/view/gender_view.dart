import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/button/selectable_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum Gender { man, woman }

class SetGenderView extends ConsumerStatefulWidget {
  const SetGenderView({super.key});

  @override
  ConsumerState<SetGenderView> createState() => _SetGenderViewState();
}

class _SetGenderViewState extends ConsumerState<SetGenderView> {
  Gender? gender;
  final Color blue = FalletterColor.blueGradient.first;
  final Color pink = FalletterColor.pinkGradient.first;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = gender != null;
    return Scaffold(
      appBar: CustomAppBar(icon: true, action: Action.orderStep, count: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text('성별을 선택해주세요', style: FalletterTextStyle.title2),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: SelectableButton(
                      label: '남성',
                      icon: Symbols.man,
                      iconColor: blue,
                      isSelected: gender == Gender.man,
                      onTap: () {
                        setState(() => gender = Gender.man);
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SelectableButton(
                      label: '여성',
                      icon: Symbols.woman,
                      iconColor: pink,
                      isSelected: gender == Gender.woman,
                      onTap: () {
                        setState(() => gender = Gender.woman);
                      },
                    ),
                  ),
                ],
              ),

              const Spacer(),

              CustomElevatedButton(
                onPressed: isEnabled
                    ? () {
                        // TODO: 다음 페이지 이동
                      }
                    : null,
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
