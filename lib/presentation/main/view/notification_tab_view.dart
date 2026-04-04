import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart' show LetterModal;
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
      ref.read(notificationProvider.notifier).loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider);
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return ContentCardButton(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        notification.imageUrl,
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
                    child: Text(
                      notification.body,
                      style: metaTextStyle,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        timeCheck(notification.createdAt),
                        style: FalletterTextStyle.body4.copyWith(
                          color: FalletterColor.gray500,
                        ),
                      ),
                      SizedBox(width: 6),
                      if (notification.type == 'BLOCK')
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LetterModal(
                                  dear: '서비스 정지 사유',
                                  content: '귀하의 계정은 서비스 이용 중 타인에게 불쾌감이나 피해를 줄 수 있는 부적절한 언행이 확인되어, 운영 정책에 따라 일시적으로 이용이 7일 제한되었습니다.',
                                  bottom: '',
                                );
                              }
                          );
                        },
                        child: Text(
                          '자세히 보기',
                          style: metaTextStyle.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: FalletterColor.gray500,
                          ),
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
                  context.go(RoutePaths.notice);
                  break;
                case 'BRICK_ACTIVATION':
                  context.go(RoutePaths.answer);
                  break;
                case 'LETTER':
                  context.go('${RoutePaths.mypage}/getLetter');
                  break;
                case 'LETTER_SENT':
                  context.go('${RoutePaths.mypage}/sendLetter');
                  break;
                case 'ADMIN_NOTICE':
                  context.go('/notification/detail', extra: notification.relatedId);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
