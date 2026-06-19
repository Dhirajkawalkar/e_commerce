/// Centralized color palette for the application.
/// 
/// This class defines the primary colors used throughout the app to ensure
/// visual consistency across different screens and components.
import 'package:flutter/material.dart';

class AppColors {
  /// The primary brand color (Deep Orange).
  static const Color primary = Color(0xFFFF7020);
  
  /// The default background color for scaffolds.
  static const Color background = Color(0xFFF8F9FA); 
  
  /// The color for surface elements like cards and dialogs.
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Primary text color for high emphasis content.
  static const Color textPrimary = Color(0xFF1A1A1A);
  
  /// Secondary text color for lower emphasis content.
  static const Color textSecondary = Color(0xFF7D7D7D);
  
  /// Color used to indicate errors or destructive actions.
  static const Color error = Color(0xFFE53935);
}
