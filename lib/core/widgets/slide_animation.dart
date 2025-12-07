import 'package:flutter/material.dart';

/// A reusable widget that animates its child with a slide effect.
/// Supports custom directions and offsets.
class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.beginOffset = const Offset(0, 0.1),
    this.endOffset = Offset.zero,
    this.direction = SlideDirection.fromBottom,
  });

  /// The widget to be animated.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The curve of the animation.
  final Curve curve;

  /// The starting offset of the slide animation.
  final Offset beginOffset;

  /// The ending offset of the slide animation.
  final Offset endOffset;

  /// Predefined slide direction (overrides beginOffset if provided).
  final SlideDirection direction;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  Offset get _computedBeginOffset {
    switch (widget.direction) {
      case SlideDirection.fromTop:
        return const Offset(0, -0.1);
      case SlideDirection.fromBottom:
        return const Offset(0, 0.1);
      case SlideDirection.fromLeft:
        return const Offset(-0.1, 0);
      case SlideDirection.fromRight:
        return const Offset(0.1, 0);
      case SlideDirection.custom:
        return widget.beginOffset;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: _computedBeginOffset,
      end: widget.endOffset,
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
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}

/// Predefined slide directions for convenience.
enum SlideDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
  custom,
}



