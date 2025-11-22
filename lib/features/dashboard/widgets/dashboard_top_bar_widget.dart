import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

/// Top bar is public so other screens (placeholder pages) can reuse it.
class DashboardTopBarWidget extends StatelessWidget {
  final VoidCallback onPressedMenu;
  const DashboardTopBarWidget({super.key, required this.onPressedMenu});

  @override
  Widget build(BuildContext context) {
    final styles = context.textStyles;
    final colors = context.appColors;
    return Row(
      children: [
        IconButton(
          onPressed: () => ZoomDrawer.of(context)?.toggle(),
          icon: const Icon(Icons.menu_sharp),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'Welcome back, Alex',
            style: styles.titleLargeTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
          backgroundColor: colors.primary.withValues(alpha: 0.15),
          child: const Icon(Icons.person_outline, size: 18),
        ),
      ],
    );
  }
}
