import 'package:flutter/material.dart';
import '../constants/constants.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BottomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: bottomButtonHeight,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: bottomButtonColor,
        ),
        child: Center(
          child: Text(
            title,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}