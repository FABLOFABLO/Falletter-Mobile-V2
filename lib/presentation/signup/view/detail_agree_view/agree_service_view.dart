import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgreeServiceView extends StatefulWidget {
  const AgreeServiceView({super.key});

  @override
  State<AgreeServiceView> createState() => _AgreeServiceViewState();
}

class _AgreeServiceViewState extends State<AgreeServiceView> {
  String text = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/text/terms_of_service.txt').then((value) {
      setState(() {
        text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '팔레터 이용약관 동의'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        child: SingleChildScrollView(
          child: Text(text, style: FalletterTextStyle.body3),
        ),
      ),
    );
  }
}
