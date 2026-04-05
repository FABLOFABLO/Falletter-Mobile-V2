import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart'
    show LetterModal;
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:falletter_mobile_v2/presentation/main/components/answer_selected_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/block_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/letter_selected_card.dart';
import 'package:falletter_mobile_v2/presentation/main/components/warning_card.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/main_notification_provider.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NotificationTabView extends ConsumerStatefulWidget {
  const NotificationTabView({super.key});

  @override
  ConsumerState<NotificationTabView> createState() =>
      _NotificationTabViewState();
}

class _NotificationTabViewState extends ConsumerState<NotificationTabView> {
  final titleStyle = FalletterTextStyle.subTitle2.copyWith(fontSize: 15);
  final metaTextStyle = FalletterTextStyle.body4.copyWith(
    color: FalletterColor.gray400,
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(mainNotificationProvider.notifier).loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(mainNotificationProvider);
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          if (notification.type == 'BLOCK') {
            return BlockCard(notification: notification);
          }

          if (notification.type == 'WARNING') {
            return WarningCard(notification: notification);
          }

          return ContentCardButton(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        notification.imageUrl!,
                        width: 20,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Symbols.error,
                            size: 20,
                            color: FalletterColor.error,
                          );
                        },
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(notification.title, style: titleStyle),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(notification.body, style: metaTextStyle),
                  ),
                  Row(
                    children: [
                      Text(
                        timeCheck(notification.createdAt),
                        style: FalletterTextStyle.body4.copyWith(
                          color: FalletterColor.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              switch (notification.type) {
                case 'COMMENT':
                  context.push(RoutePaths.notice);
                  break;
                case 'BRICK_ACTIVATION':
                  context.push(RoutePaths.answer);
                  break;
                case 'LETTER':
                  context.push('${RoutePaths.mypage}/getLetter');
                  break;
                case 'LETTER_SENT':
                  context.push('${RoutePaths.mypage}/sendLetter');
                  break;
                case 'ADMIN_NOTICE':
                  context.push(
                    '/notification/detail',
                    extra: notification.relatedId,
                  );
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
