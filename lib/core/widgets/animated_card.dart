
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

/// Card Shell that animates its properties on entrance
class AnimatedCard extends AnimatedWidget {
  const AnimatedCard({super.key,
    required this.child,
    required Animation<double> animation,
  }) : super(listenable: animation);

  final Widget child;

  // Helper to get the animation value easily
  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final radius = context.radiusTokens;

    // Animate the border and shadow color based on the animation progress
    final borderColor = Color.lerp(
      Colors.transparent, // Start transparent
      colors.textMuted.withValues(alpha: 0.8), // End with your final color
      _progress.value,
    );

    final shadowColor = Color.lerp(
      Colors.transparent, // Start transparent
      colors.onSurface.withValues(alpha: 0.3), // End with your final color
      _progress.value,
    );

    return Container( // No need for AnimatedContainer anymore
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.all16,
        border: Border.all(color: borderColor!), // Use the animated color
        boxShadow: [
          BoxShadow(
            blurRadius: 55,
            offset: const Offset(1, 1),
            color: shadowColor!, // Use the animated color
          ),
        ],
      ),
      child: child,
    );
  }
}