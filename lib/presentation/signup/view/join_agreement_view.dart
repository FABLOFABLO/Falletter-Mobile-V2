import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/models/signup_model.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/join_agreement_provider.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:falletter_mobile_v2/presentation/signup/widget/check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Agree { all, use, privacy, community, push }

class JoinAgreementView extends ConsumerWidget {
  const JoinAgreementView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(signUpProvider);
    final agreeCheck = ref.watch(agreeProvider);
    final  toggleBox = ref.read(agreeProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '약관 동의'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text(
                '${name.schoolNumber} ${name.name}님\n환영합니다!',
                style: FalletterTextStyle.title2,
              ),
              const SizedBox(height: 8),
              Text(
                '서비스 이용을 위해 약관에 동의해주세요',
                style: FalletterTextStyle.button.copyWith(
                  color: FalletterColor.gray400,
                ),
              ),
              const SizedBox(height: 34),
              CheckButton(
                toggle: toggleBox.checkBoxList,
                isChecked: agreeCheck,
              ),
              const Spacer(),
              CustomElevatedButton(
                width: double.infinity,
                onPressed: toggleBox.isCheckedToggle
                    ? () async {
                  final state = ref.read(signUpProvider);
                  final agreeState = ref.read(agreeProvider);
                  final request = SignupModel(
                      email: state.email!,
                      password: state.password!,
                      schoolNumber: state.schoolNumber!,
                      name: state.name!,
                      gender: state.gender!,
                      theme: "BLUE",
                      profileImage: "",
                      serviceTerms: agreeState[Agree.use] ?? false,
                      privacyPolicy: agreeState[Agree.privacy] ?? false,
                      communityTerms: agreeState[Agree.community] ?? false,
                      pushNotification: agreeState[Agree.push] ?? false
                  );
                  final success = await ref.read(signUpProvider.notifier).signup(request);
                  if (success) {
                    context.go('/signup/gender/complete');
                  } else {

                  }
                }
                    : null,
                child: const Text('가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
