import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that displays text as a tappable link.
///
/// It uses a [Text.rich] with a [TapGestureRecognizer] for handling taps
/// and can be styled to look like a hyperlink.
class TextLinkWidget extends StatefulWidget {
  const TextLinkWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
  });

  /// The text to display.
  final String text;

  /// The callback that is executed when the text is tapped.
  final VoidCallback? onPressed;

  /// The style to apply to the text. If null, a default link style is used.
  final TextStyle? style;

  @override
  State<TextLinkWidget> createState() => _TextLinkWidgetState();
}

class _TextLinkWidgetState extends State<TextLinkWidget> {
  late final TapGestureRecognizer _tapRecognizer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onPressed;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.textStyles.buttonTextStyle.copyWith(
      color: context.appColors.primary,
      fontSize: 12.sp(context),
    );

    // Merge the default style with the provided style.
    final effectiveStyle = widget.style ?? defaultStyle;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: RichText(
        text: TextSpan(
          text: widget.text,
          recognizer: _tapRecognizer,
          style: effectiveStyle.copyWith(
            // Add an underline on hover for a classic link feel.
            decoration: _isHovering
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: effectiveStyle.color,
          ),
        ),
      ),
    );
  }
}
