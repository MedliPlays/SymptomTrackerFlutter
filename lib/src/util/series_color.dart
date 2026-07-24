import 'package:flutter/material.dart';

/// Deterministic colour for a named data series (a symptom type), so a type
/// keeps the same colour across every chart. Mirrors the original app's
/// hash-to-hue approach.
Color seriesColor(String name) {
  var hash = 0;
  for (final unit in name.codeUnits) {
    hash = (hash * 31 + unit) & 0x7fffffff;
  }
  final hue = (hash % 360).toDouble();
  return HSVColor.fromAHSV(1, hue, 0.6, 0.85).toColor();
}
