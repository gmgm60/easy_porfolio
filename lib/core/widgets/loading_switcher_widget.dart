import 'package:easy_porfolio/core/widgets/circular_loading_widget.dart';
import 'package:flutter/material.dart';

/// A widget that animates between a child and a loading indicator
/// based on a boolean condition.
class LoadingSwitcher extends StatelessWidget {
  const LoadingSwitcher({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingIndicator,
    this.duration = const Duration(milliseconds: 200),
  });

  /// The condition to switch between the child and the loading indicator.
  /// If `true`, the [loadingIndicator] is shown.
  /// If `false`, the [child] is shown.
  final bool isLoading;

  /// The primary widget to display when [isLoading] is false.
  final Widget child;

  /// The widget to display when [isLoading] is true.
  /// Defaults to a styled [CircularProgressIndicator].
  final Widget? loadingIndicator;

  /// The duration of the switch animation.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      // The transitionBuilder provides a smoother fade effect.
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isLoading
          ? loadingIndicator ??
                const SizedBox(
                  key: ValueKey('loading'), // Add a key for the switcher

                  child: CircularLoadingWidget(),
                )
          : child,
    );
  }
}
