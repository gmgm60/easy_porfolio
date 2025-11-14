import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';

class LabelFieldWidget extends StatelessWidget {
  const LabelFieldWidget({super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textStyles.labelMediumTextStyle.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
         child,
      ],
    );
  }
}
