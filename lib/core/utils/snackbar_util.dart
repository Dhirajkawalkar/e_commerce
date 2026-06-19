/// Utility functions for displaying SnackBars.
/// 
/// This file provides a standardized way to show messages to the user
/// using the Flutter ScaffoldMessenger, with support for different
/// types (success, error, etc.) and styles.
import 'package:Cartify/core/utils/snackbar_type.dart';
import 'package:flutter/material.dart';

/// Shows a custom SnackBar at the bottom of the screen.
/// 
/// [context] is required to find the ScaffoldMessenger.
/// [message] is the text to display.
/// [type] determines the color and icon of the SnackBar.
void showCustomSnackBar(BuildContext context, String message, {SnackBarType type = SnackBarType.info}) {
  IconData icon;
  Color backgroundColor;

  // Map the SnackBarType to specific visual styles.
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

  // Dismiss current SnackBar before showing a new one.
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
