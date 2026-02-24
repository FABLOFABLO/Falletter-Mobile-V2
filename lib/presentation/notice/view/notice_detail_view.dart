import 'dart:ui';

import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/answer_button.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/notice/provider/notice_provider.dart';
import 'package:falletter_mobile_v2/presentation/notice/widget/hint_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterNoticeDetailView extends ConsumerStatefulWidget {
  final int noticeIndex;

  const FalletterNoticeDetailView({super.key, required this.noticeIndex});

  @override
  ConsumerState<FalletterNoticeDetailView> createState() =>
      _FalletterNoticeDetailViewState();
}

class _FalletterNoticeDetailViewState
    extends ConsumerState<FalletterNoticeDetailView> {
  final String _emoji = '🎧';
  final String _question = '감수성이 풍부한 사람';
  final List<String> _hints = ['ㅎ', 'ㅁ', 'ㅁ'];

  final List<String> _names = ['홍길동', '홍길동', '홍길동', '홍길동'];
  final int _highlightedIndex = 1;

  int get _totalHints => _hints.length;

  List<int> get _unlockedHints =>
      ref.read(unlockedHintsProvider(widget.noticeIndex));

  bool get _allUnlocked => _unlockedHints.length >= _totalHints;

  int get _nextHintCost => _unlockedHints.length + 1;

  Future<void> _onUnlockHint() async {
    final brickCount = ref.read(brickCountProvider);
    if (brickCount < _nextHintCost) return;

    final requiredBricks = _nextHintCost;

    final bool? result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) => HintUnlockDialog(requiredBricks: requiredBricks),
    );

    if (result == true) {
      final currentHints = ref.read(unlockedHintsProvider(widget.noticeIndex));
      ref.read(brickCountProvider.notifier).state -= requiredBricks;
      ref.read(unlockedHintsProvider(widget.noticeIndex).notifier).state = [
        ...currentHints,
        currentHints.length,
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final brickCount = ref.watch(brickCountProvider);
    final unlockedHints = ref.watch(unlockedHintsProvider(widget.noticeIndex));

    return Scaffold(
      backgroundColor: FalletterColor.black,
      appBar: CustomAppBar(
        icon: true,
        appBarAction: AppBarAction.brickCount,
        count: brickCount,
      ),
      body: unlockedHints.isEmpty
          ? _buildInitialDetailBody()
          : _buildHintBody(),
    );
  }

  Widget _buildInitialDetailBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 60),
          _buildEmojiIcon(),
          const SizedBox(height: 24),
          Text(_question, style: FalletterTextStyle.title2),
          const SizedBox(height: 40),
          _buildBlurredCards(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: _buildBottomButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHintBody() {
    final unlockedHints = ref.watch(unlockedHintsProvider(widget.noticeIndex));
    final unlockedCount = unlockedHints.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            _buildHintTitle(unlockedCount),
            style: FalletterTextStyle.title2,
          ),
          const SizedBox(height: 4),
          Text(
            "선택한 사람의 이름에 들어가는 초성입니다",
            style: FalletterTextStyle.body2.copyWith(
              color: FalletterColor.gray400,
            ),
          ),
          const SizedBox(height: 40),
          _buildHintCircles(),
          const Spacer(),
          if (!_allUnlocked) ...[
            Text(
              "더 궁금하다면?",
              style: FalletterTextStyle.subTitle2.copyWith(
                color: FalletterColor.gray200,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: _buildBottomButton(),
            ),
          ] else
            const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    final brickCount = ref.watch(brickCountProvider);
    final hasEnough = brickCount >= _nextHintCost;
    return CustomElevatedButton(
      onPressed: hasEnough ? _onUnlockHint : null,
      child: Text(hasEnough ? "브릭 사용으로 힌트 얻기" : "브릭이 부족합니다"),
    );
  }

  String _buildHintTitle(int unlockedCount) {
    if (unlockedCount >= _totalHints) {
      return "브릭 사용으로 얻은 마지막 힌트";
    }
    switch (unlockedCount) {
      case 1:
        return "브릭 사용으로 얻은 힌트";
      case 2:
        return "브릭 사용으로 얻은 두번째 힌트";
      default:
        return "브릭 사용으로 얻은 힌트";
    }
  }

  Widget _buildEmojiIcon() {
    return Container(
      width: 160,
      height: 160,
      decoration: const BoxDecoration(
        color: FalletterColor.middleBlack,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(_emoji, style: const TextStyle(fontSize: 100)),
    );
  }

  Widget _buildBlurredCards() {
    return SizedBox(
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
        itemCount: _names.length,
        itemBuilder: (context, index) {
          final isHighlighted = index == _highlightedIndex;

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnswerButton(
                    label: _names[index],
                    isSelected: false,
                    onPressed: () {},
                    showBorder: isHighlighted,
                    borderGradient: isHighlighted
                        ? LinearGradient(
                            colors: FalletterColor.blueGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHintCircles() {
    final unlockedHints = ref.watch(unlockedHintsProvider(widget.noticeIndex));
    final unlockedCount = unlockedHints.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(unlockedCount, (index) {
        final isLatest = index == unlockedCount - 1;
        final double circleSize = unlockedCount == 1 ? 130 : 100;

        return Padding(
          padding: EdgeInsets.only(right: index < unlockedCount - 1 ? 16 : 0),
          child: _hintCircle(
            text: _hints[index],
            size: circleSize,
            isLatest: isLatest,
          ),
        );
      }),
    );
  }

  Widget _hintCircle({
    required String text,
    required double size,
    required bool isLatest,
  }) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: FalletterColor.middleBlack,
      ),
      alignment: Alignment.center,
      child: isLatest
          ? ShaderMask(
              shaderCallback: (bounds) =>
                  themeColors.button.createShader(bounds),
              child: Text(
                text,
                style: FalletterTextStyle.title1.copyWith(
                  color: FalletterColor.white,
                  fontSize: 80,
                  height: 1,
                ),
              ),
            )
          : Text(
              text,
              style: FalletterTextStyle.title1.copyWith(
                color: FalletterColor.gray800,
                fontSize: 80,
                height: 1,
              ),
            ),
    );
  }
}
