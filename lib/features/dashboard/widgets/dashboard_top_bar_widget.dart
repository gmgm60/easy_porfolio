import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
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
    return ListTile(
      trailing: CircleAvatar(
        radius: 18,
        backgroundColor: colors.primary.withValues(alpha: 0.15),
        child: Icon(Icons.person_outline, size: 23.dp(context)),
      ),
      leading:         IconButton(
          onPressed:onPressedMenu,
          icon: Icon(Icons.menu_sharp, size: 30.dp(context)),
        ),
        title: Text(
          'Welcome back, Alex',
          style: styles.titleLargeTextStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ) ,
     );
   }
}
