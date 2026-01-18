import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/delete_button.dart';
import 'package:falletter_mobile_v2/core/components/button/floating_button.dart';
import 'package:falletter_mobile_v2/core/components/header/main_header.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/providers/posts_provider.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterMainView extends ConsumerStatefulWidget {
  const FalletterMainView({super.key});

  @override
  ConsumerState<FalletterMainView> createState() => _FalletterMainViewState();
}

class _FalletterMainViewState extends ConsumerState<FalletterMainView> {

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    return Scaffold(
      body: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                return ContentCardButton(
                  onTap: () {},
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
                          style: FalletterTextStyle.body4.copyWith(
                            color: FalletterColor.gray400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            post.author.name,
                            style: FalletterTextStyle.body4.copyWith(
                              color: FalletterColor.gray500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              timeCheck(post.createdAt),
                              style: FalletterTextStyle.body4.copyWith(
                                color: FalletterColor.gray500,
                              ),
                            ),
                          ),
                          Text(
                            '댓글 10개',
                            style: FalletterTextStyle.body4.copyWith(
                              color: FalletterColor.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(),
    );
  }
}
