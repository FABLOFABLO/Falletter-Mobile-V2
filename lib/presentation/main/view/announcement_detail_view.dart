import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/announcement_detail_provider.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnouncementDetailView extends ConsumerStatefulWidget {
  final int id;
  const AnnouncementDetailView({super.key, required this.id});

  @override
  ConsumerState<AnnouncementDetailView> createState() => _AnnouncementDetailViewState();
}

class _AnnouncementDetailViewState extends ConsumerState<AnnouncementDetailView> {
  @override
  Widget build(BuildContext context) {
    final metaTextStyle = FalletterTextStyle.body3.copyWith(color: FalletterColor.gray200);
    final notice = ref.watch(AnnouncementDetailProvider);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(icon: true),
          SingleChildScrollView(
            child: ContentCardButton(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            notice.authorName,
                            style: metaTextStyle,
                          ),
                          SizedBox(width: 8),
                          Text(
                            timeCheck(notice.createdAt),
                            style: metaTextStyle
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(notice.title, style: FalletterTextStyle.subTitle2,),
                      ),
                      Text(
                        notice.content,
                        style: metaTextStyle.copyWith(color: FalletterColor.gray400)
                      )
                    ],
                  ),
                ),
                onTap: () {}
            ),
          )
        ],
      ),
    );
  }
}
