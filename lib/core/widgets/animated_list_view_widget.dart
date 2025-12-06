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
  final Widget Function(
    BuildContext context,
    T item,
    Animation<double> animation,
  )
  itemBuilder;

  /// The delay between each item's animation.
  final Duration staggerDelay;

  /// The total duration of each item's animation.
  final Duration animationDuration;

  /// The starting offset for the slide animation.
  final Offset slideOffset;

  @override
  State<AnimatedListViewWidget<T>> createState() =>
      _AnimatedListViewWidgetState<T>();
}

class _AnimatedListViewWidgetState<T> extends State<AnimatedListViewWidget<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<T> _displayedItems = [];

  @override
  void initState() {
    super.initState();
    // Insert items with staggered delays to create animation effect
    _insertItemsWithStagger();
  }

  void _insertItemsWithStagger() {
    for (int i = 0; i < widget.items.length; i++) {
      final index = i;
      final item = widget.items[i];
      Future.delayed(widget.staggerDelay * index, () {
        if (mounted && index < widget.items.length) {
          setState(() {
            _displayedItems.add(item);
          });
          _listKey.currentState?.insertItem(
            index,
            duration: widget.animationDuration,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _displayedItems.length,
      itemBuilder: (context, index, animation) {

        final item = _displayedItems[index];


        return widget.itemBuilder(context, item, animation);
      },
    );
  }
}
