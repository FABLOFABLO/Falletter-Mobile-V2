import 'package:falletter_mobile_v2/core/components/button/floating_button.dart';
import 'package:falletter_mobile_v2/core/components/header/main_header.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/providers/auth_status_provider.dart';
import 'package:falletter_mobile_v2/core/providers/bottom_nav_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/signup_provider.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/widget/sign_up_complete_modal.dart';
import 'package:falletter_mobile_v2/features/letter/data/model/get_letter_model.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/provider/get_letter_provider.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/utils/letter_check_util.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/widget/letter_popup.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/posts_provider.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

bool hasShownLetterPopupThisSession = false;

class FalletterMainView extends ConsumerStatefulWidget {
  const FalletterMainView({super.key});

  @override
  ConsumerState<FalletterMainView> createState() => _FalletterMainViewState();
}

class _FalletterMainViewState extends ConsumerState<FalletterMainView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await ref.read(userApiService).getUserInfo();
      final theme = AppThemeParser.fromString(user.theme);
      ref.read(themeProvider.notifier).changeTheme(theme);

      ref.read(postsProvider.notifier).loadPosts();

      final isSignupComplete =
      ref.read(signupCompleteProvider);

      if (isSignupComplete && context.mounted) {
        await showGeneralDialog(
          context: context,
          barrierDismissible: false,
          pageBuilder: (_, __, ___) {
            return const SignUpCompleteModal();
          },
        );

        ref.read(signupCompleteProvider.notifier).state = false;
      }

      if (hasShownLetterPopupThisSession) return;

      await ref.read(getLetterProvider.notifier).getLetterList();
      final letters = ref.read(getLetterProvider);

      final newLetters = await getNewLetters(letters);

      if (newLetters.isNotEmpty && context.mounted) {
        hasShownLetterPopupThisSession = true;

        await _showLetter(newLetters);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void resetScroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _showLetter(List<GetLetterModel> letters) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LetterPopup(letters: letters),
    );

    for (final letter in letters) {
      if (!context.mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LetterModal(
          dear: 'dear',
          content: letter.content,
          bottom: '누군가 보냄',
        ),
      );

      await markAsSeen(letter.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    ref.listen(bottomNavIndexProvider, (previous, current) {
      if (current == 0) {
        Future.microtask(() => resetScroll());
      }
    });

    return Scaffold(
      body: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: context.cardBg,
              color: themeColors.primaryColor,
              onRefresh: () async {
                await ref.read(postsProvider.notifier).loadPosts();
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return ContentCardButton(
                    onTap: () {
                      context.push('${RoutePaths.main}/detail', extra: post.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: FalletterTextStyle.subTitle2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              post.content,
                              style: FalletterTextStyle.body4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                post.anonymousNickname,
                                style: FalletterTextStyle.body4,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  timeCheck(post.createdAt),
                                  style: FalletterTextStyle.body4,
                                ),
                              ),
                              Text(
                                '댓글 ${post.commentCount}개',
                                style: FalletterTextStyle.body4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        onTap: () {
          context.push('${RoutePaths.main}/create');
        },
      ),
    );
  }
}
