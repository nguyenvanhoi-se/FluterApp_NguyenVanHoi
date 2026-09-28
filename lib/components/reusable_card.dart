import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ReusableCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  const ReusableCard({
    super.key,
    required this.child,
    this.color = activeCardColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}