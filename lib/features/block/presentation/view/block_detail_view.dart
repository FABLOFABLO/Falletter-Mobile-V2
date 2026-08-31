import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:falletter_mobile_v2/features/block/data/model/blocked_post_model.dart';
import 'package:falletter_mobile_v2/features/block/presentation/provider/block_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BlockDetailView extends ConsumerStatefulWidget {
  final BlockedPostModel post;

  const BlockDetailView({super.key, required this.post});

  @override
  ConsumerState<BlockDetailView> createState() => _BlockDetailViewState();
}

class _BlockDetailViewState extends ConsumerState<BlockDetailView> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: SafeArea(
        child: Column(
          children: [
            ContentCardButton(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.anonymousNickname,
                          style: FalletterTextStyle.body3.copyWith(
                            color: FalletterColor.gray500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          timeCheck(post.blockedAt),
                          style: FalletterTextStyle.body3.copyWith(
                            color: FalletterColor.gray400,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        post.title,
                        style: FalletterTextStyle.subTitle2,
                      ),
                    ),
                    Text(
                      post.content,
                      style: FalletterTextStyle.body3.copyWith(
                        color: context.subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: CustomElevatedButton(
                child: Text('차단 해제하기'),
                onPressed: () async {
                  if (_isSubmitting) return;
                  _isSubmitting = true;
                  try {
                    await ref.read(blockListProvider.notifier).unblock(post.blockId);
                    if (!mounted) return;
                    context.pop();
                    successSnackBar(context, '차단이 해제되었어요.');
                  } catch (_) {
                    if (!mounted) return;
                    errorSnackBar(context, '차단 해제에 실패했어요.');
                  } finally {
                    _isSubmitting = false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
