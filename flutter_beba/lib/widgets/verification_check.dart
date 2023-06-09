import 'package:flutter/material.dart';

class VerificationIcon extends StatelessWidget {
  final double size;
  final Color color;

  const VerificationIcon({
    super.key, 
    this.size = 24.0,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: size / 8),
      ),
      child: Icon(
        Icons.check,
        color: color,
        size: size / 2,
      ),
    );
  }
}