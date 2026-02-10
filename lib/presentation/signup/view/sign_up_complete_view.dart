import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/detail_agree_view/agree_service_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserComplete extends StatefulWidget {
  const UserComplete({super.key});

  @override
  State<UserComplete> createState() => _UserCompleteState();
}

class _UserCompleteState extends State<UserComplete>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: false),
      body: Stack(
        children: [
          /// 배경에 홈 페이지 넣기
          Lottie.asset(
            'assets/lottie/congratulation.json',
            controller: _animationController,
            onLoaded: (onLoaded) {
              _animationController.duration = onLoaded.duration;
              _animationController.forward().then((_) {
              /// 홈 페이지로 넘어가기
              });
            },
          ),

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
