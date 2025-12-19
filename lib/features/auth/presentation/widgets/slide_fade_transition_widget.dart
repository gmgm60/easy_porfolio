import 'package:flutter/material.dart';

/// A widget that animates its child with a slide and fade transition.
/// The animation starts automatically when the widget is built.
class SlideFadeTransitionWidget extends StatefulWidget {
  const SlideFadeTransitionWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = const Offset(-0.2, 0), // Default slide from the left
    this.curve = Curves.easeOutCubic,
  });

  /// The widget to be animated.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The starting offset of the slide animation.
  /// Defaults to `Offset(-0.2, 0)` for a slide from the left.
  final Offset offset;

  /// The curve of the animation.
  final Curve curve;

  @override
  State<SlideFadeTransitionWidget> createState() => _SlideFadeTransitionWidgetState();
}

class _SlideFadeTransitionWidgetState extends State<SlideFadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _slideAnimation = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    // Start the animation after the specified delay.
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
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}