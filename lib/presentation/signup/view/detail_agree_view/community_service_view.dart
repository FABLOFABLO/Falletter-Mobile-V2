import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommunityServiceView extends StatefulWidget {
  const CommunityServiceView({super.key});

  @override
  State<CommunityServiceView> createState() => _CommunityServiceViewState();
}

class _CommunityServiceViewState extends State<CommunityServiceView> {
  String text = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/text/community_service.txt').then((value) {
      setState(() {
        text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '커뮤니티 이용약관 동의'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        child: SingleChildScrollView(
          child: Text(text, style: FalletterTextStyle.body3),
        ),
      ),
    );
  }
}
