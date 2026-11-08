import 'package:flutter/material.dart';

/// Local responsive sizing helper for the Home module only.
/// Keeps the original design values as base (reference device width/height)
/// and exposes small helpers used throughout lib/ui/screens/home.
class SizeConfig {
  // Reference design size (keep original Home values as base)
  static const double baseWidth = 390.0;
  static const double baseHeight = 844.0;

  static double _scale(BuildContext context) {
    final scale = screenWidth(context) / baseWidth;
    return scale.clamp(0.85, 1.10);
  }

  static double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

  /// Responsive width based on screen width with clamp.
  static double w(BuildContext context, double value) {
    return value * _scale(context);
  }

  /// Responsive height also uses the same width-based scale.
  static double h(BuildContext context, double value) {
    return value * _scale(context);
  }

  static EdgeInsets all(BuildContext context, double value) {
    return EdgeInsets.all(w(context, value));
  }

  static EdgeInsets only(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: w(context, left),
      top: h(context, top),
      right: w(context, right),
      bottom: h(context, bottom),
    );
  }

  static EdgeInsets symmetric(
    BuildContext context, {
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: w(context, horizontal),
      vertical: h(context, vertical),
    );
  }

  static BorderRadius circular(BuildContext context, double radius) {
    return BorderRadius.circular(w(context, radius));
  }
}

/// BuildContext extension available only in Home module files where this
/// file is imported. Adds `.width` and `.height` accessors required by the
/// user's spec.
extension HomeContextSize on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}
