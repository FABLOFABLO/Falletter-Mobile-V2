import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/features/auth/data/model/signup_model.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/sign_in_provider.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/join_agreement_provider.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/signup_provider.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/widget/check_button.dart';
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
    final toggleBox = ref.read(agreeProvider.notifier);

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
                style: FalletterTextStyle.button,
              ),
              const SizedBox(height: 34),
              CheckButton(
                toggle: toggleBox.checkBoxList,
                isChecked: agreeCheck,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomElevatedButton(
                  width: double.infinity,
                  onPressed: toggleBox.isCheckedToggle
                      ? () async {
                    final state = ref.read(signUpProvider);
                    final agreeState = ref.read(agreeProvider);
                    final request = SignupModel(
                        email: "${state.email!}@dsm.hs.kr",
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
                      await ref.read(signInProvider.notifier).signIn(
                          email: state.email!.trim(),
                          password: state.password!
                      );
                      context.go(RoutePaths.signupComplete);
                    } else {
                      errorSnackBar(context, '회원가입에 실패했습니다.\n다시 시도해주세요.');
                    }
                  }
                      : null,
                  child: Text('가입하기', style: TextStyle(color: context.reverseTextColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
