import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/view/answer_view.dart';
import 'package:falletter_mobile_v2/features/history/presentation/view/brick_history_view.dart';
import 'package:falletter_mobile_v2/features/theme/presentation/view/theme_select_view.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/view/letter_view.dart';
import 'package:falletter_mobile_v2/features/roulette/presentation/widget/roulette.dart';
import 'package:falletter_mobile_v2/features/roulette/presentation/view/roulette_reward_view.dart';
import 'package:falletter_mobile_v2/features/roulette/presentation/view/roulette_view.dart';
import 'package:falletter_mobile_v2/features/notice/data/model/notice_models.dart';
import 'package:falletter_mobile_v2/features/post/data/model/post_detail_model.dart';
import 'package:falletter_mobile_v2/features/main/presentation/view/main_view.dart';
import 'package:falletter_mobile_v2/features/notification/presentation/view/notification_view.dart';
import 'package:falletter_mobile_v2/features/post/presentation/view/post_detail_view.dart';
import 'package:falletter_mobile_v2/features/post/presentation/view/post_create_view.dart';
import 'package:falletter_mobile_v2/features/post/presentation/view/post_edit_view.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/view/get_letter_view.dart';
import 'package:falletter_mobile_v2/features/user/presentation/view/mypage_view.dart';
import 'package:falletter_mobile_v2/features/announcement/presentation/view/announcement_detail_view.dart';
import 'package:falletter_mobile_v2/features/notification/presentation/view/notification_setting_view.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/view/send_letter_view.dart';
import 'package:falletter_mobile_v2/features/notice/presentation/view/notice_view.dart';
import 'package:falletter_mobile_v2/features/notice/presentation/view/notice_detail_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_in/signin_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/email_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/join_agreement_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/password_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/school_number_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/sign_up_complete_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/verify_code_view.dart';
import 'package:falletter_mobile_v2/features/splash/presentation/view/splash_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/gender_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashView(),
      ),
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
            builder: (_, __) => const SchoolNumberView()
          ),
          GoRoute(
              path: 'email',
              builder: (_, __) => const EmailView()
          ),
          GoRoute(
              path: 'verifyCode',
              builder: (_, __) => const VerifyCodeView()
          ),
          GoRoute(
              path: 'password',
              builder: (_, __) => const PasswordView()
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        builder: (_, __) => const SigninView(),
      ),
      GoRoute(
        path: '/roulette',
        builder: (_, __) => const RouletteView(),
      ),
      GoRoute(
          path: '/reward',
          pageBuilder: (context, state) {
            final reward = state.extra as Reward;
            return CustomTransitionPage(
              opaque: false,
              child: RouletteRewardView(type: reward.type, amount: reward.amount,),
              transitionsBuilder: (context, anim1, anim2, child) => FadeTransition(opacity: anim1, child: child),
            );
          }
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
                    },
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
