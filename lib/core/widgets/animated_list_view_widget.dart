import 'package:flutter/material.dart';

/// A widget that displays a list of items with a staggered slide and fade animation.
class AnimatedListViewWidget<T> extends StatefulWidget {
  const AnimatedListViewWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.staggerDelay = const Duration(milliseconds: 80),
    this.animationDuration = const Duration(milliseconds: 400),
    this.slideOffset = const Offset(-0.1, 0),
  });

  /// The list of data items to display.
  final List<T> items;

  /// A builder function that creates the widget for each item.
  /// It receives the context, the item data, and the animation.
  final Widget Function(BuildContext context, T item, Animation<double> animation) itemBuilder;

  /// The delay between each item's animation.
  final Duration staggerDelay;

  /// The total duration of each item's animation.
  final Duration animationDuration;

  /// The starting offset for the slide animation.
  final Offset slideOffset;

  @override
  State<AnimatedListViewWidget<T>> createState() => _AnimatedListViewWidgetState<T>();
}

class _AnimatedListViewWidgetState<T> extends State<AnimatedListViewWidget<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // The total duration is based on the number of items and the stagger delay.
      duration: widget.staggerDelay * widget.items.length,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];

        // Calculate the start and end time for this specific item's animation.
        final double startTime = (widget.staggerDelay.inMilliseconds * index) / _controller.duration!.inMilliseconds;
        final double endTime = startTime + (widget.animationDuration.inMilliseconds / _controller.duration!.inMilliseconds);

        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startTime,
            endTime > 1.0 ? 1.0 : endTime, // Ensure endTime doesn't exceed 1.0
            curve: Curves.easeOutCubic,
          ),
        );

        // Use the provided itemBuilder to build the final widget.
        return widget.itemBuilder(context, item, animation);
      },
    );
  }
}