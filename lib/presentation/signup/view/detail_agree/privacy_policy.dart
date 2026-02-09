import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true,title: '개인정보 및 이용동의 동의',),
    );
  }
}
