import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailNotification extends StatefulWidget {
  final String title;

  const DetailNotification({super.key, required this.title});

  @override
  State<DetailNotification> createState() => _DetailNotificationState();
}

class _DetailNotificationState extends State<DetailNotification> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: FalletterTextStyle.body2.copyWith(
              fontSize: 15,
              color: FalletterColor.gray400,
            ),
          ),
          SizedBox(
            height: 20,
            width: 36,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                height: 35,
                width: 57,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: isEnabled
                      ? FalletterGradient.horizontal(
                          FalletterColor.blueGradient,
                        )
                      : null,
                  color: isEnabled ? null : FalletterColor.gray400,
                ),
                child: CupertinoSwitch(
                  thumbIcon: WidgetStateProperty.all(Icon(null)),
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  value: isEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
