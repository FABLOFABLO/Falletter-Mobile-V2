import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyView extends ConsumerStatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  ConsumerState<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends ConsumerState<PrivacyPolicyView> {
  String text = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/text/personal_information_consent.txt').then((
      value,
    ) {
      setState(() {
        text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeColorsProvider) == ThemeMode.dark;
    final textColor = isDark ? FalletterColor.gray200 : FalletterColor.white;
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '개인정보 및 이용동의 동의'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 26),
        child: SingleChildScrollView(
          child: Text(
            text,
            style: FalletterTextStyle.body3.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
