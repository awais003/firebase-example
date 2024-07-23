

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = 100,
    this.height = 45,
    this.backgroundColor = Colors.deepPurple,
    this.textColor = Colors.white,
    this.isInProgress = false,
  });

  final Function onPressed;
  final String label;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isInProgress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
        )
      ),
      child: isInProgress? SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
          strokeWidth: 2,
        ),
      ) : Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
