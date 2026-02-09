import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatelessWidget {
  const PushNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true,title: '푸시 알림 동의',),
    );
  }
}
