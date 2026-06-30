import 'package:flutter/material.dart';

/// Centralized Border Radii constants for ShinkaTrack widgets.
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  static BorderRadius get radiusSM => BorderRadius.circular(sm);
  static BorderRadius get radiusMD => BorderRadius.circular(md);
  static BorderRadius get radiusLG => BorderRadius.circular(lg);
  static BorderRadius get radiusXL => BorderRadius.circular(xl);

  static RoundedRectangleBorder get shapeSM => RoundedRectangleBorder(borderRadius: radiusSM);
  static RoundedRectangleBorder get shapeMD => RoundedRectangleBorder(borderRadius: radiusMD);
  static RoundedRectangleBorder get shapeLG => RoundedRectangleBorder(borderRadius: radiusLG);
  static RoundedRectangleBorder get shapeXL => RoundedRectangleBorder(borderRadius: radiusXL);
}
