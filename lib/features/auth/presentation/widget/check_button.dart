import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/detail_agree/agree_service_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/detail_agree/community_service_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/detail_agree/privacy_policy_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/detail_agree/push_notification_view.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/view/sign_up/join_agreement_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckButton extends ConsumerStatefulWidget {
  final Map<Agree, bool> isChecked;
  final void Function(Agree) toggle;

  const CheckButton({super.key, required this.toggle, required this.isChecked});

  @override
  ConsumerState<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends ConsumerState<CheckButton> {
  final Map<Agree, WidgetBuilder?> navigator = {
    Agree.all: null,
    Agree.use: (_) => AgreeServiceView(),
    Agree.privacy: (_) => PrivacyPolicyView(),
    Agree.community: (_) => CommunityServiceView(),
    Agree.push: (_) => PushNotificationView(),
  };

  @override
  Widget build(BuildContext context) {
    return _listCheckText();
  }

  Widget _listCheckText() {
    final style = FalletterTextStyle.agreeService;
    final blueStyle = FalletterTextStyle.button;
    Map<Agree, Widget> labels = {
      Agree.all: Text('약관 전체 동의', style: FalletterTextStyle.body1),
      Agree.use: Text.rich(
        TextSpan(
          text: '팔레터 이용약관 동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Agree.privacy: Text.rich(
        TextSpan(
          text: '개인정보 수집 및 이용동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Agree.community: Text.rich(
        TextSpan(
          text: '커뮤니티 이용약관 동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Agree.push: Text.rich(
        TextSpan(
          text: '푸시 알림 동의 ',
          style: style,
          children: [TextSpan(text: '(선택)', style: blueStyle)],
        ),
      ),
    };
    List<Widget> list = [
      renderContainer(
        widget.isChecked[Agree.all] ?? false,
        labels[Agree.all]!,
        () => widget.toggle(Agree.all),
        null,
      ),
      const Divider(thickness: 1),
    ];
    list.addAll(
      List.generate(Agree.values.length - 1, (index) {
        final type = Agree.values[index + 1];
        return renderContainer(
          widget.isChecked[type] ?? false,
          labels[type]!,
          () {
            widget.toggle(type);
          },
          navigator[type],
        );
      }),
    );
    return Column(children: list,);
  }

  Widget renderContainer(
    bool checked,
    Widget text,
    VoidCallback onTap,
    WidgetBuilder? navigator,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 22),
        color: context.bgColor,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: checked ? FalletterColor.blueGradient[0] : FalletterColor.gray400,
              ),
              child: checked
                  ? const Icon(Symbols.check, size: 20)
                  : const SizedBox(height: 20, width: 20),
            ),
            const SizedBox(width: 12),
            text,
            const Spacer(),
            if (navigator != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: navigator));
                },
                child: const Icon(
                  Symbols.arrow_forward_ios,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
