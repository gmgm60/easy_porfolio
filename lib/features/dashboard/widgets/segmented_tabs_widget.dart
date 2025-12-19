import 'package:flutter/material.dart';

import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';

/// A customizable segmented control widget built on the official [SegmentedButton].
class SegmentedTabsWidget extends StatelessWidget {
  const SegmentedTabsWidget({
    super.key,
    required this.options,
    required this.current,
    required this.onChanged,
  });

  /// The list of string options to display as tabs.
  final List<String> options;

  /// The currently selected option.
  final String current;

  /// Callback executed when a new option is selected.
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final styles = context.textStyles;

    return SegmentedButton<String>(
      // The segments are the individual buttons. We map the options list to this.
      segments: options.map((option) {
        return ButtonSegment<String>(value: option, label: Text(option));
      }).toList(),

      // The 'selected' property requires a Set. Since we only have one selection,
      // we create a Set containing just the current item.
      selected: {current},

      // When a new segment is tapped, this callback is fired. It returns a Set.
      // We take the first item from the set and pass it to our onChanged callback.
      onSelectionChanged: (newSelection) {
        onChanged(newSelection.first);
      },

      // --- Styling ---
      // This is where we apply your custom theme to match your app's look.
      style: SegmentedButton.styleFrom(
        // Background color for the entire component.
        backgroundColor: colors.surface.withValues(alpha: 0.5),

        // Color and border for the selected segment.
        foregroundColor: colors.onSurface,
        selectedForegroundColor: colors.primary,
        selectedBackgroundColor: colors.surface,

        // Text style for the labels.
        textStyle: styles.labelMediumTextStyle,

        // Define the shape of the button.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}
