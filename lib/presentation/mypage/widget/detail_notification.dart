import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailNotification extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final void Function(bool) onTap;

  const DetailNotification({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FalletterTextStyle.body2.copyWith(
              fontSize: 15,
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
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  value: isEnabled,
                  onChanged: onTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
