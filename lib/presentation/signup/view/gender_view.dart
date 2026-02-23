import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/button/selectable_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SetGenderView extends ConsumerWidget {
  const SetGenderView({super.key});

  void _selectGender(WidgetRef ref, String value) {
    ref.read(signUpProvider.notifier).setGender(value);
  }

  static final Color blue = FalletterColor.blueGradient.first;
  static final Color pink = FalletterColor.pinkGradient.first;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGender = ref.watch(signUpProvider.select((gender)=>gender.gender));
    final isNextStep = ref.watch(signUpProvider.select((enabled)=>enabled.gender?.isNotEmpty ?? false));

    return Scaffold(
      appBar: CustomAppBar(icon: true, appBarAction: AppBarAction.orderStep, count: 1),
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
                      isSelected: selectGender == 'MALE',
                      onTap: () {
                        _selectGender(ref, 'MALE');
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SelectableButton(
                      label: '여성',
                      icon: Symbols.woman,
                      iconColor: pink,
                      isSelected: selectGender == 'FEMALE',
                      onTap: () {
                        _selectGender(ref, 'FEMALE');
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: isNextStep
                    ? () {
                        /// TODO: 다음 페이지 이동
                      }
                    : null,
                width: double.infinity,
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
