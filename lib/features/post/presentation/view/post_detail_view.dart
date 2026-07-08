import 'package:dio/dio.dart';
import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/button/send_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/default_modal.dart';
import 'package:falletter_mobile_v2/core/components/progress/loading_circular_indicator.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/report_provider.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/posts_detail_provider.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final int postId;

  const PostDetailView({super.key, required this.postId});

  @override
  ConsumerState<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _reportController = TextEditingController();
  final baseInfoStyle = FalletterTextStyle.body3;
  final commentInfoStyle = FalletterTextStyle.body4;
  final maxLength = 200;
  final reportSvg = 'assets/svg/report/siren.svg';

  @override
  void initState() {
    _commentController.addListener(_onChanged);
    _reportController.addListener(_onChanged);
    Future.microtask(() {
      ref.read(postsDetailProvider.notifier).loadDetailPost(widget.postId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _reportController.dispose();
    super.dispose();
  }

  bool get isEnabled => _commentController.text.trim().isNotEmpty;

  bool get isReportEnabled => _reportController.text.trim().isNotEmpty;

  void _onChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(postsDetailProvider);
    final myInfo = ref.watch(userInfoProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (post == null) {
      return Container(
        color: context.bgColor,
        child: loadingCircularIndicator(ref)
      );
    }

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
                              post.anonymousNickname,
                              style: baseInfoStyle,
                            ),
                            SizedBox(width: 8),
                            Text(
                              timeCheck(post.updatedAt),
                              style: baseInfoStyle
                            ),
                            SizedBox(height: 48)
                          ],
                        ),
                        if (myInfo.value?.id != null && myInfo.value?.id == post.authorId)
                          IconButton(
                            icon: const Icon(
                              Symbols.more_horiz,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: context.cardBg,
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
                                                onRightPressed: () {
                                                  ref.read(postsDetailProvider.notifier).deletePost(widget.postId);
                                                  context.go(RoutePaths.main);
                                                },
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
                                              style: FalletterTextStyle.button,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          context.push('${RoutePaths.main}/edit', extra: post);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        else if (myInfo.value?.id != null && myInfo.value?.id != post.authorId)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => GestureDetector(
                                    onTap: FocusScope.of(context).unfocus,
                                    child: Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: context.bgColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('게시글 신고', style: FalletterTextStyle.subTitle2.copyWith(color: context.textColor),),
                                                    Spacer(),
                                                    IconButton(
                                                        padding: EdgeInsets.zero,
                                                        visualDensity: VisualDensity.compact,
                                                        onPressed: () {
                                                          context.pop();
                                                          _reportController.clear();
                                                        },
                                                        icon: Icon(Symbols.close,
                                                          color: FalletterColor.gray200,
                                                        )
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Text('사유 입력', style: FalletterTextStyle.body2.copyWith(color: isDark ? FalletterColor.gray200 : FalletterColor.gray800),),
                                                      Spacer(),
                                                      ListenableBuilder(
                                                        listenable: _reportController,
                                                        builder: (context, child) => Text.rich(
                                                          TextSpan(
                                                              children: [
                                                                TextSpan(text: '${_reportController.text.length}', style: baseInfoStyle.copyWith(color: context.textColor)),
                                                                TextSpan(text: '/$maxLength', style: baseInfoStyle.copyWith(color: FalletterColor.gray500))
                                                              ]
                                                          )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 20),
                                                  child: CustomTextFormField(
                                                    maxLength: maxLength,
                                                    controller: _reportController,
                                                    decoration: InputDecoration(
                                                      hintText: '신고 사유를 입력해주세요.',
                                                      counterText: ''
                                                    ),
                                                    maxLines: ((MediaQuery.sizeOf(context).height -
                                                                MediaQuery.viewInsetsOf(context).bottom -
                                                                340) /
                                                            26)
                                                        .floor()
                                                        .clamp(1, 12),
                                                  ),
                                                ),
                                                ListenableBuilder(
                                                  listenable: _reportController,
                                                  builder: (context, child) => GestureDetector(
                                                    onTap: isReportEnabled ? () async {
                                                      final navigator = Navigator.of(context);
                                                      try {
                                                        await ref.read(reportProvider.notifier).addReport(
                                                            post.id,
                                                            _reportController.text.trim()
                                                        );
                                                        if (!mounted) return;
                                                        navigator.pop();
                                                        _reportController.clear();
                                                        successSnackBar(this.context, '신고가 접수되었습니다.');
                                                      } on DioException catch (e) {
                                                        if (!mounted) return;
                                                        navigator.pop();
                                                        _reportController.clear();
                                                        errorSnackBar(this.context, e.response?.statusCode == 409
                                                              ? '이미 신고한 게시글입니다.'
                                                              : '신고에 실패했습니다.',
                                                        );
                                                      }
                                                    } : null,
                                                    child: Container(
                                                      width: 350,
                                                      height: 52,
                                                      decoration: BoxDecoration(
                                                        color: isReportEnabled ? FalletterColor.error : FalletterColor.gray900,
                                                        borderRadius: BorderRadius.circular(8)
                                                      ),
                                                      child: Center(child: Text('신고', style: FalletterTextStyle.subTitle2.copyWith(color: FalletterColor.white),),),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      ),
                                  )
                              );
                            },
                            child: SvgPicture.asset(reportSvg),
                          )
                      ],
                    ),
                    Text(post.title, style: FalletterTextStyle.subTitle2),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        post.content,
                        style: baseInfoStyle
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
                                      comment.anonymousNickname,
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
                                  style: baseInfoStyle
                                ),
                              ],
                            ),
                          ),
                          if (myInfo.value?.id != null && myInfo.value?.id == comment.userId)
                            IconButton(
                              onPressed: () {
                                ref.read(postsDetailProvider.notifier).deleteComment(
                                    comment.commentId,
                                    post.id
                                );
                              },
                              icon: const Icon(
                                Symbols.delete,
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
            SafeArea(
              top: false,
              child: Padding(
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
                      child: SendButton(isEnabled: isEnabled, onPressed: () {
                        FocusScope.of(context).unfocus();
                        ref.read(postsDetailProvider.notifier).addComment(
                            widget.postId,
                            _commentController.text
                        );
                        _commentController.text = '';
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
