import 'package:flutter/material.dart';
import 'package:easy_porfolio/features/auth/presentation/widgets/slide_fade_transition_widget.dart';
import 'package:easy_porfolio/core/widgets/slide_animation.dart';
import 'package:easy_porfolio/core/widgets/fade_scale_animation.dart';

/// A widget that applies staggered animations to a list of children.
/// Each child animates with a delay based on its index.
class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.animationType = StaggeredAnimationType.fadeScale,
    this.slideDirection = SlideDirection.fromBottom,
  });

  /// The list of widgets to animate.
  final List<Widget> children;

  /// The delay between each child's animation.
  final Duration staggerDelay;

  /// The duration of each child's animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve curve;

  /// The type of animation to apply.
  final StaggeredAnimationType animationType;

  /// The slide direction (only used if animationType is slide or fadeSlide).
  final SlideDirection slideDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        children.length,
        (index) {
          final delay = staggerDelay * index;
          final child = children[index];

          switch (animationType) {
            case StaggeredAnimationType.fadeScale:
              return FadeScaleAnimation(
                delay: delay,
                duration: animationDuration,
                curve: curve,
                child: child,
              );
            case StaggeredAnimationType.fadeSlide:
              return SlideFadeTransitionWidget(
                delay: delay,
                duration: animationDuration,
                curve: curve,
                offset: _getOffsetForDirection(slideDirection),
                child: child,
              );
            case StaggeredAnimationType.slide:
              return SlideAnimation(
                delay: delay,
                duration: animationDuration,
                curve: curve,
                direction: slideDirection,
                child: child,
              );
          }
        },
      ),
    );
  }

  Offset _getOffsetForDirection(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromTop:
        return const Offset(0, -0.1);
      case SlideDirection.fromBottom:
        return const Offset(0, 0.1);
      case SlideDirection.fromLeft:
        return const Offset(-0.1, 0);
      case SlideDirection.fromRight:
        return const Offset(0.1, 0);
      case SlideDirection.custom:
        return const Offset(0, 0.1);
    }
  }
}

/// Types of staggered animations available.
enum StaggeredAnimationType {
  fadeScale,
  fadeSlide,
  slide,
}

