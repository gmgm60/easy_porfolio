import 'package:flutter/material.dart';

/// A reusable widget that animates its child with fade and scale effects.
/// Useful for entrance animations and transitions.
class FadeScaleAnimation extends StatefulWidget {
  const FadeScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.beginScale = 0.8,
    this.endScale = 1.0,
    this.beginOpacity = 0.0,
    this.endOpacity = 1.0,
  });

  /// The widget to be animated.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The curve of the animation.
  final Curve curve;

  /// The starting scale value (0.0 to 1.0).
  final double beginScale;

  /// The ending scale value (0.0 to 1.0).
  final double endScale;

  /// The starting opacity value (0.0 to 1.0).
  final double beginOpacity;

  /// The ending opacity value (0.0 to 1.0).
  final double endOpacity;

  @override
  State<FadeScaleAnimation> createState() => _FadeScaleAnimationState();
}

class _FadeScaleAnimationState extends State<FadeScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}


