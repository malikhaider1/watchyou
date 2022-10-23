import 'package:flutter/material.dart';

class KElevatedButton extends StatelessWidget {
  const KElevatedButton({
    Key? key,
    required this.title,
    required this.color,
    required this.opacity,
    required this.size,
    required this.ontap,
    this.maximumSize,
    this.minimumSize,
    required this.borderRadius,
    required this.textColor,
  }) : super(key: key);

  final String title;
  final Color color;
  final double opacity;
  final double size;
  final VoidCallback ontap;
  final Size? maximumSize;
  final Size? minimumSize;
  final double borderRadius;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          side: BorderSide(
              color: Colors.white.withOpacity(opacity),
              style: BorderStyle.solid,
              width: 2),
          elevation: 0.5,
          backgroundColor: color,
          maximumSize: maximumSize,
          minimumSize: minimumSize),
      onPressed: ontap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: size, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }
}