import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DeleteButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double size;

  const DeleteButton({
    super.key,
    required this.onPressed,
    this.size = 32,
  });

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool _isPressed = false;

  void _tapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onPressed();
  }

  void _tapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _isPressed ? FalletterColor.error : FalletterColor.middleBlack,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Symbols.delete,
          color: _isPressed ? FalletterColor.white : FalletterColor.gray400,
        ),
      ),
    );
  }
}
