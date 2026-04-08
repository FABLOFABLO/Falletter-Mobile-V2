import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/answer_button.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/models/notice_models.dart';
import 'package:falletter_mobile_v2/presentation/notice/provider/notice_provider.dart';
import 'package:falletter_mobile_v2/presentation/notice/widget/hint_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterNoticeDetailView extends ConsumerStatefulWidget {
  final NoticeItem notice;

  const FalletterNoticeDetailView({super.key, required this.notice});

  @override
  ConsumerState<FalletterNoticeDetailView> createState() =>
      _FalletterNoticeDetailViewState();
}

class _FalletterNoticeDetailViewState
    extends ConsumerState<FalletterNoticeDetailView> {
  final List<String> _names = ['홍길동', '홍길동', '홍길동', '홍길동'];
  final int _highlightedIndex = 1;
  static const List<String> _choseong = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ',
  ];

  String get _noticeId => widget.notice.id.toString();
  int get _answerId => widget.notice.id;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(noticeDetailProvider(_noticeId).notifier);
      notifier.initFromNoticeItem(widget.notice);
      notifier.fetchHint(_answerId);
    });
  }

  int _getNextHintCost(HintData? hintData) {
    final unlockedCount = hintData?.unlockedCount ?? 0;
    return unlockedCount + 1;
  }

  List<String> _extractInitialHints(String name) {
    final initials = <String>[];
    for (final rune in name.runes) {
      final code = rune;
      if (code >= 0xAC00 && code <= 0xD7A3) {
        final choseongIndex = (code - 0xAC00) ~/ 588;
        initials.add(_choseong[choseongIndex]);
      } else {
        final char = String.fromCharCode(code).trim();
        if (char.isNotEmpty) {
          initials.add(char.substring(0, 1).toUpperCase());
        }
      }
    }
    return initials;
  }

  String _nextHintValue(HintData? hintData) {
    final nextIndex = hintData?.unlockedCount ?? 0;
    final initials = _extractInitialHints(widget.notice.name);
    if (nextIndex < initials.length) {
      return initials[nextIndex];
    }
    return '?';
  }

  Future<void> _onUnlockHint(NoticeDetail detail) async {
    final notifier = ref.read(noticeDetailProvider(_noticeId).notifier);
    HintData? hintData = detail.hintData;
    final nextCost = _getNextHintCost(hintData);
    final brickCount = ref.read(brickCountProvider);

    if (brickCount < nextCost) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('브릭이 부족합니다.')));
      }
      return;
    }

    final bool? result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) => HintUnlockDialog(requiredBricks: nextCost),
    );

    if (result == true) {
      final nextHintValue = _nextHintValue(hintData);
      bool success;
      if (hintData == null) {
        success = await notifier.saveHint(
          answerId: _answerId,
          firstHint: nextHintValue,
        );
      } else {
        success = await notifier.unlockNextHint(
          answerId: _answerId,
          hintId: hintData.id > 0 ? hintData.id : null,
          currentHint: hintData,
          newHintValue: nextHintValue,
        );
      }

      if (success) {
        ref.read(brickCountProvider.notifier).state -= nextCost;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('힌트 열기에 실패했습니다. 다시 시도해 주세요.')),
          );
        }
      }
    }
  }

  Future<void> _onRefresh() async {
    await ref
        .read(noticeDetailProvider(_noticeId).notifier)
        .fetchHint(_answerId);
  }

  @override
  Widget build(BuildContext context) {
    final brickCount = ref.watch(brickCountProvider);
    final detailAsync = ref.watch(noticeDetailProvider(_noticeId));

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: CustomAppBar(
        icon: true,
        appBarAction: AppBarAction.brickCount,
        count: brickCount,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: context.middleColor,
        color: context.textColor,
        child: detailAsync.when(
          loading: () => Center(
            child: CircularProgressIndicator(color: context.textColor),
          ),
          error: (error, _) => Center(
            child: Text('알림을 불러올 수 없습니다.', style: FalletterTextStyle.body2),
          ),
          data: (detail) {
            final hintData = detail.hintData;
            final hasHints = hintData != null && hintData.unlockedCount > 0;

            return hasHints
                ? _buildHintBody(detail, hintData!)
                : _buildInitialDetailBody(detail);
          },
        ),
      ),
    );
  }

  Widget _buildInitialDetailBody(NoticeDetail detail) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildEmojiIcon(detail.emoji),
            const SizedBox(height: 24),
            Text(
              detail.question,
              textAlign: TextAlign.center,
              style: FalletterTextStyle.title2,
            ),
            const SizedBox(height: 40),
            _buildBlurredCards(),
            const SizedBox(height: 80),
            _buildBottomButton(detail),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHintBody(NoticeDetail detail, HintData hintData) {
    final unlockedCount = hintData.unlockedCount;
    final allUnlocked = hintData.allUnlocked;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  _buildHintTitle(unlockedCount),
                  textAlign: TextAlign.center,
                  style: FalletterTextStyle.title2,
                ),
                const SizedBox(height: 4),
                Text(
                  "선택한 사람의 이름에 들어가는 초성입니다",
                  style: FalletterTextStyle.body2,
                ),
                const SizedBox(height: 40),
                _buildHintCircles(hintData),
                const Spacer(),
                if (!allUnlocked) ...[
                  Text(
                    "더 궁금하다면?",
                    style: FalletterTextStyle.subTitle2,
                  ),
                  const SizedBox(height: 16),
                  _buildBottomButton(detail),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(NoticeDetail detail) {
    final brickCount = ref.watch(brickCountProvider);
    final nextCost = _getNextHintCost(detail.hintData);
    final hasEnough = brickCount >= nextCost;

    return CustomElevatedButton(
      onPressed: hasEnough ? () => _onUnlockHint(detail) : null,
      child: Text(hasEnough ? "브릭 사용으로 힌트 얻기" : "브릭이 부족합니다"),
    );
  }

  String _buildHintTitle(int unlockedCount) {
    if (unlockedCount >= 3) {
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

  Widget _buildEmojiIcon(String emoji) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: context.middleColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        emoji.isNotEmpty ? emoji : '🎧',
        style: const TextStyle(fontSize: 100),
      ),
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

  Widget _buildHintCircles(HintData hintData) {
    final unlockedHints = hintData.unlockedHints;
    final unlockedCount = unlockedHints.length;
    final allUnlocked = hintData.allUnlocked;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(unlockedCount, (index) {
        final isLatest = index == unlockedCount - 1;
        // 모두 열었으면 전부 gradient, 아니면 최신 힌트만 gradient
        final useGradient = allUnlocked || isLatest;
        final double circleSize = unlockedCount == 1 ? 130 : 100;
        final hintText = hintData.hintAt(unlockedHints[index]) ?? '?';

        return Padding(
          padding: EdgeInsets.only(right: index < unlockedCount - 1 ? 16 : 0),
          child: _hintCircle(
            text: hintText,
            size: circleSize,
            useGradient: useGradient,
          ),
        );
      }),
    );
  }

  Widget _hintCircle({
    required String text,
    required double size,
    required bool useGradient,
  }) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.cardBg,
      ),
      alignment: Alignment.center,
      child: useGradient
          ? ShaderMask(
              shaderCallback: (bounds) =>
                  themeColors.button.createShader(bounds),
              child: Text(
                text,
                style: FalletterTextStyle.title1.copyWith(
                  color: Colors.white,
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
