import 'package:falletter_mobile_v2/presentation/main/components/answer_selected_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/block_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/letter_selected_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/warning_card.dart';
import 'package:flutter/material.dart';

class NotificationTabView extends StatefulWidget {
  const NotificationTabView({super.key});

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          AnswerSelectedCard(),
          LetterSelectedCard(),
          BlockCard(days: 7),
          WarningCard(),
        ],
      ),
    );
  }
}
