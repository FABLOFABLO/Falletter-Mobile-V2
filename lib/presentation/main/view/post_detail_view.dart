import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/button/send_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/default_modal.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:falletter_mobile_v2/core/providers/posts_detail_provider.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final int postId;

  const PostDetailView({super.key, required this.postId});

  @override
  ConsumerState<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  final TextEditingController _commentController = TextEditingController();
  final baseInfoStyle = FalletterTextStyle.body3.copyWith(color: FalletterColor.gray200);
  final commentInfoStyle = FalletterTextStyle.body4.copyWith(color: FalletterColor.gray200);

  @override
  void initState() {
    _commentController.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool get isEnabled => _commentController.text.trim().isNotEmpty;

  void _onChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(postsDetailProvider);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            CustomAppBar(icon: true),
            ContentCardButton(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.author.name,
                              style: baseInfoStyle,
                            ),
                            SizedBox(width: 8),
                            Text(
                              timeCheck(post.updatedAt),
                              style: baseInfoStyle
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Symbols.more_horiz,
                            color: FalletterColor.white,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: FalletterColor.middleBlack,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '삭제',
                                            style: FalletterTextStyle.button.copyWith(
                                                  color: FalletterColor.error,
                                                ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (context) => Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                            ),
                                            child: DefaultModal(
                                              title: '게시물 삭제',
                                              description: '게시물이 영구 삭제됩니다.\n정말 삭제하시겠어요?',
                                              leftButton: '취소',
                                              rightButton: '삭제',
                                              onLeftPressed: () {
                                                Navigator.pop(context);
                                              },
                                              onRightPressed: () {},
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(color: FalletterColor.gray900),
                                    ListTile(
                                      title: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            '수정',
                                            style: FalletterTextStyle.button
                                                .copyWith(
                                                  color: FalletterColor.gray50,
                                                ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        context.push('${RoutePaths.main}/posts/edit', extra: post);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(post.title, style: FalletterTextStyle.subTitle2),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        post.content,
                        style: baseInfoStyle.copyWith(color: FalletterColor.gray400)
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: post.comment.length,
                itemBuilder: (BuildContext context, int index) {
                  final comment = post.comment[index];
                  return ContentCardButton(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      comment.user.name,
                                      style: commentInfoStyle,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      timeCheck(comment.updatedAt),
                                      style: commentInfoStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  comment.comment,
                                  style: baseInfoStyle.copyWith(color: FalletterColor.gray50)
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Symbols.delete,
                              color: FalletterColor.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
            Divider(thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: _commentController,
                      maxLines: 1,
                      decoration: InputDecoration(hintText: '댓글을 작성하세요'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SendButton(isEnabled: isEnabled, onPressed: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
