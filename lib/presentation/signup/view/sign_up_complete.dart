import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class UserComplete extends StatelessWidget {
  const UserComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: Stack(
        children: [
          /// 배경에 홈 페이지 넣기
          Image.asset('assets/svg/complete.png',width: double.infinity,fit: BoxFit.cover,),
          Align(
            alignment: Alignment(0, -0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('가입 완료!', style: FalletterTextStyle.subTitle1),
                const SizedBox(height: 8),
                Text('팔레터를 사용해보세요', style: FalletterTextStyle.title2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
