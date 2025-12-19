import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

/// Card Shell with a hover tilt effect
class CustomAnimatedCard extends StatefulWidget {
  const CustomAnimatedCard({super.key, required this.child});
  final Widget child;

  @override
  State<CustomAnimatedCard> createState() => CustomAnimatedCardState();
}

class CustomAnimatedCardState extends State<CustomAnimatedCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final radius = context.radiusTokens;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: TweenAnimationBuilder(
        // Animate the transform property
        tween: Tween<Matrix4>(
          begin: Matrix4.identity(),
          end: _isHovering
              ? (Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateX(0.03) // Tilt on X-axis
            ..rotateY(-0.03)) // Tilt on Y-axis
              : Matrix4.identity(),
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        builder: (context, Matrix4 value, child) {
          return Transform(
            transform: value,
            alignment: FractionalOffset.center,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: radius.all16,
                border: Border.all(color: colors.textMuted.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 55,
                    offset: const Offset(1, 1),
                    color: colors.onSurface.withValues(alpha: 0.3),
                  ),
                ],
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}