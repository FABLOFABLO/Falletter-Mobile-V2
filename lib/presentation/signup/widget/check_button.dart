import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/detail_agree_view/agree_service_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/detail_agree_view/community_service_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/detail_agree_view/privacy_policy_view.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/detail_agree_view/push_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CheckButton extends StatefulWidget {
  final List<bool> isChecked;
  final void Function(int) toggle;

  const CheckButton({super.key, required this.toggle, required this.isChecked});

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  final navigator = [
    null,
    (_) => AgreeServiceView(),
    (_) => PrivacyPolicyView(),
    (_) => CommunityServiceView(),
    (_) => PushNotificationView(),
  ];

  @override
  Widget build(BuildContext context) {
    return _listCheckText();
  }

  Widget _listCheckText() {
    final style = FalletterTextStyle.agreeService;
    final blueStyle = FalletterTextStyle.button.copyWith(
      color: FalletterColor.blue,
    );
    List<Widget> labels = [
      Text('약관 전체 동의', style: FalletterTextStyle.body1),
      Text.rich(
        TextSpan(
          text: '빨레터 이용약관 동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Text.rich(
        TextSpan(
          text: '개인정보 수집 및 이용동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Text.rich(
        TextSpan(
          text: '커뮤니티 이용약관 동의 ',
          style: style,
          children: [TextSpan(text: '(필수)', style: blueStyle)],
        ),
      ),
      Text.rich(
        TextSpan(
          text: '푸시 알림 동의 ',
          style: style,
          children: [TextSpan(text: '(선택)', style: blueStyle)],
        ),
      ),
    ];
    List<Widget> list = [
      renderContainer(
        widget.isChecked[0],
        labels[0],
        () => widget.toggle(0),
        null,
      ),
      const Divider(thickness: 1),
    ];
    list.addAll(
      List.generate(
        4,
        (index) => renderContainer(
          widget.isChecked[index + 1],
          labels[index + 1],
          () => widget.toggle(index + 1),
          navigator[index + 1],
        ),
      ),
    );
    return Column(children: list);
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
        color: FalletterColor.black,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: checked ? FalletterColor.blue : FalletterColor.gray400,
              ),
              child: checked
                  ? Icon(Symbols.check, size: 20, color: FalletterColor.white)
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
                child: Icon(
                  Symbols.arrow_forward_ios,
                  color: FalletterColor.gray400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
