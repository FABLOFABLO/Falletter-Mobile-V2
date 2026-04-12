import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/brick_history_provider.dart';
import 'package:falletter_mobile_v2/presentation/mypage/widget/brick_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrickHistoryView extends ConsumerStatefulWidget {
  const BrickHistoryView({super.key});

  @override
  ConsumerState<BrickHistoryView> createState() => _SelectState();
}

class _SelectState extends ConsumerState<BrickHistoryView> {
  static const double spacing = 20;

  @override
  void initState() {
    Future.microtask(() {
      ref.read(brickHistoryProvider.notifier).loadBrickList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brickHistory = ref.watch(brickHistoryProvider);
    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacing),
            Text('브릭 사용 내역', style: FalletterTextStyle.title2),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: brickHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  final bricks = brickHistory[index];
                  return BrickHistory(
                    title: bricks.description,
                    brick: bricks.amount,
                    question: bricks.question,
                    time: bricks.createdAt,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
