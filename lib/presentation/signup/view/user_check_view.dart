import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/sign_up_complete_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/widget/check_button.dart';
import 'package:flutter/material.dart';

class UserCheckView extends StatefulWidget {
  const UserCheckView({super.key});

  @override
  State<UserCheckView> createState() => _UserCheckViewState();
}

class _UserCheckViewState extends State<UserCheckView> {
  List<bool> _isChecked = List.generate(5, (_) => false);

  bool get _isCheckedToggle => _isChecked[1] && _isChecked[2] && _isChecked[3];

  void _checkBoxList(int index) {
    setState(() {
      if (index == 0) {
        bool isAllChecked = !_isChecked.every((element) => element);
        _isChecked = List.generate(5, (index) => isAllChecked);
      } else {
        _isChecked[index] = !_isChecked[index];
        _isChecked[0] = _isChecked.getRange(1, 5).every((element) => element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '약관 동의'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text('3209 유하은님\n환영합니다!', style: FalletterTextStyle.title2),
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
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const SignUpCompleteView(),
                          ),
                          (route) => false,
                        );
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
