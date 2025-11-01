
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Store it inside ThemeData so you can access it declaratively.
class SystemBars extends ThemeExtension<SystemBars> {
  final SystemUiOverlayStyle overlay;
  const SystemBars(this.overlay);

  @override
  SystemBars copyWith({SystemUiOverlayStyle? overlay}) => SystemBars(overlay ?? this.overlay);

  @override
  SystemBars lerp(ThemeExtension<SystemBars>? other, double t) =>
      t < .5 ? this : (other as SystemBars);
}

extension SystemBarsX on ThemeData {
  SystemUiOverlayStyle get systemBars => extension<SystemBars>()!.overlay;
}