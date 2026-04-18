import 'package:flutter/material.dart';
import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:e_commerce/core/utils/snackbar_type.dart';

void showCustomSnackBar(BuildContext context, String message, {SnackBarType type = SnackBarType.info}) {
  IconData icon;
  Color backgroundColor;

  switch (type) {
    case SnackBarType.success:
      icon = Icons.check_circle_outline;
      backgroundColor = const Color(0xFF4CAF50); // Green
      break;
    case SnackBarType.warning:
      icon = Icons.warning_amber_outlined;
      backgroundColor = const Color(0xFFFFC107); // Amber
      break;
    case SnackBarType.error:
      icon = Icons.error_outline;
      backgroundColor = const Color(0xFFF44336); // Red
      break;
    case SnackBarType.info:
    default:
      icon = Icons.info_outline;
      backgroundColor = const Color(0xFF2196F3); // Blue
      break;
  }

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16.0),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
        ],
      ),
    ),
  );
}
