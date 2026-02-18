import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:falletter_mobile_v2/presentation/signup/widget/check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Agree { all, use, privacy, community, push }

class JoinAgreementView extends ConsumerStatefulWidget {
  const JoinAgreementView({super.key});

  @override
  ConsumerState<JoinAgreementView> createState() => _JoinAgreementViewState();
}

class _JoinAgreementViewState extends ConsumerState<JoinAgreementView> {
  final Map<Agree, bool> _isChecked = {
    Agree.all: false,
    Agree.use: false,
    Agree.privacy: false,
    Agree.community: false,
    Agree.push: false,
  };

  bool get _isCheckedToggle =>
      (_isChecked[Agree.use] ?? false) &&
      (_isChecked[Agree.privacy] ?? false) &&
      (_isChecked[Agree.community] ?? false);

  void _checkBoxList(Agree type) {
    setState(() {
      if (type == Agree.all) {
        bool allTrue = !(_isChecked[Agree.all] ?? false);
        _isChecked.updateAll((key, value) => allTrue);
      } else {
        _isChecked[type] = !(_isChecked[type] ?? false);
        _isChecked[Agree.all] =
            _isChecked[Agree.use]! &&
            _isChecked[Agree.privacy]! &&
            _isChecked[Agree.community]! &&
            _isChecked[Agree.push]!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(signUpProvider);
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
              CheckButton(toggle: _checkBoxList, isChecked: _isChecked),
              const Spacer(),
              CustomElevatedButton(
                width: double.infinity,
                onPressed: _isCheckedToggle
                    ? () {
                        context.go('/signup/complete');
                      }
                    : null,
                child: Text('가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
