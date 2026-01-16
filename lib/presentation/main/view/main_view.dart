import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/custon_bottom_nav_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/delete_button.dart';
import 'package:falletter_mobile_v2/core/components/button/floating_button.dart';
import 'package:falletter_mobile_v2/core/components/header/main_header.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';

class FalletterMainView extends StatefulWidget {
  const FalletterMainView({super.key});

  @override
  State<FalletterMainView> createState() => _FalletterMainViewState();
}

class _FalletterMainViewState extends State<FalletterMainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return ContentCardButton(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '내일 1학년 1반 시간표 바뀌었다는데 아시는분 계신가요?',
                        style: FalletterTextStyle.subTitle2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          '시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!시간표 바뀐거 아시는 분 댓글 달아주세요ㅜㅜ!',
                          style: FalletterTextStyle.body4.copyWith(
                            color: FalletterColor.gray400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '네모의꿈',
                            style: FalletterTextStyle.body4.copyWith(
                              color: FalletterColor.gray500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              timeCheck(DateTime(2025, 3, 24)),
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
