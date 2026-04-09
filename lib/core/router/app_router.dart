import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/models/notice_models.dart';
import 'package:falletter_mobile_v2/models/post_detail_model.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/answer_view.dart';
import 'package:falletter_mobile_v2/presentation/letter/view/letter_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/main_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/notification_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_create_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_edit_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/brick_history_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/get_letter_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/mypage_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/announcement_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/notification_setting_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/send_letter_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/theme_select_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/send_letter_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/get_letter_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/brick_history_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/roulette/components/roulette.dart';
import 'package:falletter_mobile_v2/presentation/roulette/roulette_reward_view.dart';
import 'package:falletter_mobile_v2/presentation/roulette/roulette_view.dart';
import 'package:falletter_mobile_v2/presentation/signin/view/signin_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/email_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/join_agreement_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/password_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/school_number_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/sign_up_complete_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/verify_code_view.dart';
import 'package:falletter_mobile_v2/presentation/splash/view/splash_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/gender_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashView()),
      GoRoute(
        path: '/signup/gender',
        builder: (_, __) => const SetGenderView(),
        routes: [
          GoRoute(
            path: 'joinAgree',
            builder: (_, __) => const JoinAgreementView(),
          ),
          GoRoute(
            path: 'complete',
            builder: (_, __) => const SignUpCompleteView(),
          ),
          GoRoute(
            path: 'schoolNumber',
            builder: (_, __) => const SchoolNumberView(),
          ),
          GoRoute(path: 'email', builder: (_, __) => const EmailView()),
          GoRoute(
            path: 'verifyCode',
            builder: (_, __) => const VerifyCodeView(),
          ),
          GoRoute(path: 'password', builder: (_, __) => const PasswordView()),
        ],
      ),
      GoRoute(path: '/signin', builder: (_, __) => const SigninView()),
      GoRoute(path: '/roulette', builder: (_, __) => const RouletteView()),
      GoRoute(
        path: '/reward',
        pageBuilder: (context, state) {
          final reward = state.extra as Reward;
          return CustomTransitionPage(
            opaque: false,
            child: RouletteRewardView(type: reward.type, amount: reward.amount),
            transitionsBuilder: (context, anim1, anim2, child) =>
                FadeTransition(opacity: anim1, child: child),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.main,
                builder: (_, __) => const FalletterMainView(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      return PostDetailView(postId: state.extra as int);
                    },
                  ),
                  GoRoute(
                    path: 'create',
                    builder: (_, __) => const PostCreateView(),
                  ),
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final post = state.extra as PostDetailModel;
                      return PostEditView(
                        postId: post.id,
                        title: post.title,
                        content: post.content,
                      );
                    }
                  ),
                ],
              ),
              GoRoute(
                path: '/notification',
                builder: (_, __) => const NotificationView(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      return AnnouncementDetailView(id: state.extra as int);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.letter,
                builder: (_, __) => const FalletterLetterView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.answer,
                builder: (_, __) => const FalletterAnswerView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.notice,
                builder: (_, __) => const FalletterNoticeView(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      return FalletterNoticeDetailView(
                        notice: state.extra as NoticeItem,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.mypage,
                builder: (_, __) => const FalletterMypageView(),
                routes: [
                  GoRoute(
                      path: 'sendLetter',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const SendLetterView()
                  ),
                  GoRoute(
                    path: 'getLetter',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, __) => const GetLetterView()
                  ),
                  GoRoute(
                      path: 'brickHistory',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const BrickHistoryView()
                  ),
                  GoRoute(
                      path: 'themeSelect',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const ThemeSelectView()
                  ),
                  GoRoute(
                      path: 'notificationSetting',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const NotificationSettingView()
                  ),
                ]
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
