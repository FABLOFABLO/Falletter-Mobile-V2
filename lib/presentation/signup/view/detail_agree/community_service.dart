import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CommunityService extends StatelessWidget {
  const CommunityService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true,title: '커뮤니티 이용약관 동의',),
    );
  }
}
