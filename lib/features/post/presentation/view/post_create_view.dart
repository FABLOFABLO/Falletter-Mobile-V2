import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/post/presentation/provider/posts_provider.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostCreateView extends ConsumerStatefulWidget {
  const PostCreateView({super.key});

  @override
  ConsumerState<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends ConsumerState<PostCreateView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final int maxLength = 200;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onChanged);
    _contentController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
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
      onTap: FocusScope.of(context).unfocus,
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
                      CustomTextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(hintText: '제목을 입력하세요'),
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
                        decoration: InputDecoration(counterText: '', hintText: '부적절하거나 불쾌감을 줄 수 있는 컨텐츠는\n제재를 받을 수 있습니다'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 35),
              child: CustomElevatedButton(
                width: double.infinity,
                onPressed: isEnabled
                    ? () async {
                  final postId = await ref.read(postsProvider.notifier).addPost(
                      _titleController.text,
                      _contentController.text
                  );
                  context.pushReplacement('${RoutePaths.main}/detail', extra: postId);
                }
                    : null,
                child: Text('글 등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
