import 'package:flutter/material.dart';
// import 'package:kuvaka_bhavesh/utils/app_color.dart';

Widget buildCustomButton({
  required String buttonText,
  required VoidCallback onTap,
  Color? buttonColor,
  Color? textColor,
  double textSize = 18,
  double horizontalPadding = 24.0,
  double verticalPadding = 16.0,
  double borderRadius = 20.0,
  double? width, // Optional width to constrain the button
}) {
  return Align(
    alignment: Alignment.center, // Align to avoid stretching
    child: Container(
      width: width, // Set the width only if provided
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: buttonColor ?? Color(0xFF25AD34),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: textSize,
              color: textColor ?? Color(0xFF413F3F),
            ),
          ),
        ),
      ),
    ),
  );
}
