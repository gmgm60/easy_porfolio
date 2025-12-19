import 'package:easy_porfolio/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';


/// Extensions for ergonomic usage in widgets.
extension ResponsiveExtensions on num {

  /// Scale for font sizes with clamping.
  double sp(BuildContext context) =>
     ResponsiveUtil.scaleFont(context, toDouble());

  /// Scale for dimensions: padding, margins, etc.
  double dp(BuildContext context) =>
      ResponsiveUtil.scale(context, toDouble());

}
