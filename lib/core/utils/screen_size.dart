
import 'package:flutter/material.dart';

/// Defines screen-size buckets based on device width thresholds.
enum ScreenSize {
  mobile(390),
  tablet(650),
  desktop(1364);

  final double threshold;
  const ScreenSize(this.threshold);
}

/// Returns the [ScreenSize] bucket for the current device.
ScreenSize getScreenSize(BuildContext context) {

  final width = MediaQuery.sizeOf(context).width;
  if (width >= ScreenSize.desktop.threshold) {
    return ScreenSize.desktop;
  }
  if (width >= ScreenSize.tablet.threshold) {
    return ScreenSize.tablet;
  }
  return ScreenSize.mobile;
}
