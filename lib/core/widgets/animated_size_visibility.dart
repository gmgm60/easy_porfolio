import 'package:flutter/material.dart';

/// A widget that animates its child's appearance and disappearance
/// using an AnimatedSize transition.
class AnimatedSizeVisibility extends StatelessWidget {
  const AnimatedSizeVisibility({
    super.key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeOutCubic,
  });

  /// The condition to show or hide the child.
  final bool isVisible;

  /// The widget to animate.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The curve for the animation.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: curve,
      // The child of AnimatedSize is what changes.
      // When isVisible is false, we render an empty box,
      // and AnimatedSize will animate its size down to zero.
      child: isVisible ? child : const SizedBox.shrink(),
    );
  }
}