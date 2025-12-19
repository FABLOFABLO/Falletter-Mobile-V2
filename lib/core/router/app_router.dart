import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/providers/bottom_nav_provider.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/answer_view.dart';
import 'package:falletter_mobile_v2/presentation/letter/view/letter_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/main_view.dart';
import 'package:falletter_mobile_v2/presentation/mypage/view/mypage_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.main,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                if (index == navigationShell.currentIndex) {
                  navigationShell.goBranch(index, initialLocation: true);
                } else {
                  ref.read(bottomNavIndexProvider.notifier).state = index;
                  navigationShell.goBranch(index);
                }
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
