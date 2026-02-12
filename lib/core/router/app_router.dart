import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/models/post_detail_model.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/answer_view.dart';
import 'package:falletter_mobile_v2/presentation/letter/view/letter_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/main_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/notification_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_create_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_edit_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/mypage_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/announcement_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_view.dart';
import 'package:falletter_mobile_v2/presentation/signin/view/signin_view.dart';
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
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashView(),
      ),
      GoRoute(
        path: '/signup/gender',
        builder: (_, __) => const SetGenderView(),
      ),
      GoRoute(
        path: '/signin',
        builder: (_, __) => const SigninView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                navigationShell.goBranch(index);
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
                      return PostEditView(title: post.title, content: post.content);
                    }
                  ),
                ]
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
                        }
                    ),
                  ]
              )
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
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.mypage,
                builder: (_, __) => const FalletterMypageView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});