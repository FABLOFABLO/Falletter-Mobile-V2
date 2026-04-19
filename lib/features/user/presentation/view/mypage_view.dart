import 'package:falletter_mobile_v2/core/components/modal/default_modal.dart';
import 'package:falletter_mobile_v2/core/components/progress/loading_progress_indicator.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/auth_status_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/splash/presentation/provider/slpashFromLogoutProvider.dart';
import 'package:falletter_mobile_v2/features/user/presentation/widget/menu_button.dart';
import 'package:falletter_mobile_v2/features/item/presentation/provider/brick_count_provider.dart';
import 'package:falletter_mobile_v2/features/item/presentation/provider/letter_count_provider.dart';
import 'package:falletter_mobile_v2/features/user/data/model/my_info_model.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/user_info_provider.dart';
import 'package:falletter_mobile_v2/features/item/presentation/widget/item_container.dart';
import 'package:falletter_mobile_v2/features/user/presentation/widget/my_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FalletterMypageView extends ConsumerStatefulWidget {
  const FalletterMypageView({super.key});

  @override
  ConsumerState<FalletterMypageView> createState() => _FalletterMypageViewState();
}

class _FalletterMypageViewState extends ConsumerState<FalletterMypageView> {

  static const SizedBox betweenHeight = SizedBox(height: 12);
  static const SizedBox titleHeight = SizedBox(height: 32);
  static const SizedBox betweenWidth = SizedBox(width: 12);
  static final style = FalletterTextStyle.button.copyWith(
    color: FalletterColor.gray400,
  );

  Future<void> _Exit(BuildContext context) async {
    final tokenStorage = ref.read(tokenStorageProvider);

    await tokenStorage.clear();

    ref.invalidate(userInfoProvider);
    ref.invalidate(authStatusProvider);

    ref.read(themeProvider.notifier).changeTheme(AppTheme.blue);
    ref.read(splashFromLogoutProvider.notifier).state = true;

    if (context.mounted) {
      context.pop();
      context.go('/splash');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(letterProvider.notifier).loadLetterCount();
      ref.read(brickCountProvider.notifier).loadBrickCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final myInfo = ref.watch(userInfoProvider);
    final letterState = ref.watch(letterProvider);
    final brickState = ref.watch(brickCountProvider);
    final letterCount = letterState.value?.count.letterCount ?? 0;
    final brickCount = brickState.value?.brickCount ?? 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: myInfo.when(
              error: (Object error, StackTrace stackTrace) {
                return Center(child: Text('오류입니다 다시 시도해주세요.'));
              },
              loading: () => loadingCircularIndicator(ref),
              data: (UserInfoModel data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleHeight,
                    MyContainer(
                      name: data.name,
                      image: data.profileImage,
                    ),
                    titleHeight,
                    Row(
                      children: [
                        ItemContainer(item: themeColors.letterSvg, count: letterCount),
                        betweenWidth,
                        ItemContainer(
                          item: themeColors.brickSvg,
                          count: brickCount,
                        ),
                      ],
                    ),
                    titleHeight,
                    Text('내역', style: style),
                    betweenHeight,
                    MenuButton(
                      title: '보낸 레터',
                      onTap: () {
                        context.push(RoutePaths.sendLetter);
                      },
                    ),
                    betweenHeight,
                    MenuButton(
                      title: '받은 레터',
                      onTap: () {
                        context.push(RoutePaths.getLetter);
                      },
                    ),
                    betweenHeight,
                    MenuButton(
                      title: '브릭 사용 내역',
                      onTap: () {
                        context.push(RoutePaths.brickHistory);
                      },
                    ),
                    titleHeight,
                    Text('시스템', style: style),
                    betweenHeight,
                    MenuButton(
                      title: '테마 설정',
                      onTap: () {
                        context.go('${RoutePaths.themeSelect}');
                      },
                    ),
                    betweenHeight,
                    MenuButton(
                      title: '알림 설정',
                      onTap: () {
                        context.go('${RoutePaths.notificationSetting}');
                      },
                    ),
                    titleHeight,
                    Text('계정', style: style),
                    betweenHeight,
                    accountButton(
                      context: context,
                      redText: false,
                      title: '로그아웃',
                      description:
                          '기기내 계정에서 로그아웃 할 수 있어요\n다음 이용 시에는 다시 로그인 해야합니다.\n정말 로그아웃하시겠어요?',
                      rightButtonText: '로그아웃',
                      onConfirm: () async {
                        try {
                          final apiService = ref.read(userInfoApiService);
                          await apiService.logout();
                          await _Exit(context);
                        } catch (e) {
                          await _Exit(context);
                        }
                      },
                    ),
                    betweenHeight,
                    accountButton(
                      context: context,
                      redText: true,
                      title: '회원 탈퇴',
                      description:
                          '회원을 탈퇴하시면 지금까지의 진행 상황을 잃고\n다시 복구할 수 없어요\n정말 회원 탈퇴 하시겠습니까?',
                      rightButtonText: '탈퇴',
                      onConfirm: () async {
                        try {
                          final apiService = ref.read(userInfoApiService);
                          await apiService.withdraw();
                          await _Exit(context);
                        } catch (e) {
                          errorSnackBar(context, '회원탈퇴에 실패했습니다.');
                          return;
                        }
                      },
                    ),

                    const SizedBox(height: 76),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget accountButton({
    required BuildContext context,
    required bool redText,
    required String title,
    required String description,
    required String rightButtonText,
    required VoidCallback onConfirm,
  }) {
    return MenuButton(
      redText: redText,
      title: title,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DefaultModal(
            title: title,
            description: description,
            leftButton: '취소',
            rightButton: rightButtonText,
            onLeftPressed: () => context.pop(),
            onRightPressed: onConfirm,
          ),
        );
      },
    );
  }
}
