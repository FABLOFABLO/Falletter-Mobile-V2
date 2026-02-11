import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/announcement_provider.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnnouncementView extends ConsumerStatefulWidget {
  const AnnouncementView({super.key});

  @override
  ConsumerState<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends ConsumerState<AnnouncementView> {
  @override
  Widget build(BuildContext context) {
    final metaTextStyle = FalletterTextStyle.body4.copyWith(
        color: FalletterColor.gray500);
    final notices = ref.watch(AnnouncementProvider);
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notices.length,
        itemBuilder: (BuildContext context, int index) {
          final notice = notices[index];
          return ContentCardButton(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notice.title, style: FalletterTextStyle.subTitle2),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        notice.authorName,
                        style: metaTextStyle,
                      ),
                      SizedBox(width: 8),
                      Text(
                        timeCheck(notice.createdAt),
                        style: metaTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              context.push('/announcement/detail', extra: notice.id);
            },
          );
        },
      ),
    );
  }
}
