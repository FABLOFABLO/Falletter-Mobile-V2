import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/posts_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostEditView extends ConsumerStatefulWidget {
  final int postId;
  final String title;
  final String content;

  const PostEditView({
    super.key,
    required this.postId,
    required this.title,
    required this.content
  });

  @override
  ConsumerState<PostEditView> createState() => _PostEditViewState();
}

class _PostEditViewState extends ConsumerState<PostEditView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final int maxLength = 200;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _contentController.text = widget.content;

    _titleController.addListener(_onChanged);
    _contentController.addListener(_onChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  bool get isEnabled =>
      _titleController.text.trim().isNotEmpty
          && _contentController.text.trim().isNotEmpty;

  void _onChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(icon: true),
            SizedBox(height: 46),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('제목을 입력해주세요', style: FalletterTextStyle.subTitle1),
                      SizedBox(height: 10),
                      AbsorbPointer(
                        child: CustomTextFormField(
                          controller: _titleController,
                          readOnly: true,
                          style: FalletterTextStyle.placeholder,
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '내용을 입력해주세요',
                            style: FalletterTextStyle.subTitle1,
                          ),
                          Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: '${_contentController.text.length}', style: FalletterTextStyle.body2.copyWith(color: context.textColor)),
                                    TextSpan(text: '/$maxLength', style: FalletterTextStyle.body2.copyWith(color: FalletterColor.gray500))
                                  ]
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _contentController,
                        maxLength: maxLength,
                        maxLines: 9,
                        decoration: InputDecoration(counterText: ''),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 50),
              child: CustomElevatedButton(
                width: double.infinity,
                onPressed: isEnabled
                    ? () async {
                  await ref.read(postsDetailProvider.notifier).editPost(
                      widget.postId,
                      _titleController.text,
                      _contentController.text
                  );
                  context.pop();
                }
                    : null,
                child: Text('수정하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
