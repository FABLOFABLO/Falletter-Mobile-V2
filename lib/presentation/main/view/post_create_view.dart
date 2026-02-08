import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/button/send_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/main/view/post_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostCreateView extends StatefulWidget {
  const PostCreateView({super.key});

  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
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
                        decoration: InputDecoration(hintText: 'Placeholder'),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '내용을 입력해주세요',
                            style: FalletterTextStyle.subTitle1,
                          ),
                          RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: '${_contentController.text.length}', style: FalletterTextStyle.body2),
                                  TextSpan(text: '/$maxLength', style: FalletterTextStyle.body2.copyWith(
                                    color: FalletterColor.gray500
                                  ))
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
              padding: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 30),
              child: CustomElevatedButton(
                child: Text('글 등록하기'),
                width: double.infinity,
                onPressed: isEnabled
                    ? () {
                  int dummyPostid = 2;
                  context.pushReplacement('/posts/detail', extra: dummyPostid);
                }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
