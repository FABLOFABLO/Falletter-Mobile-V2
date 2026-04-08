import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/delete_button.dart';
import 'package:falletter_mobile_v2/core/components/button/floating_button.dart';
import 'package:falletter_mobile_v2/core/components/header/main_header.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/providers/bottom_nav_provider.dart';
import 'package:falletter_mobile_v2/core/providers/comments_provider.dart';
import 'package:falletter_mobile_v2/core/providers/posts_provider.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    Future.microtask(() {
      ref.read(postsProvider.notifier).loadPosts();
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

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
