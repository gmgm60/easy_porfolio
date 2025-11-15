import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/admin_home/data/models/drawer_item.dart';
import 'package:flutter/material.dart';

class DrawerMenuTileWidget extends StatefulWidget {
  const DrawerMenuTileWidget({
    super.key,
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  final DrawerItem data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<DrawerMenuTileWidget> createState() => _DrawerMenuTileWidgetState();
}

class _DrawerMenuTileWidgetState extends State<DrawerMenuTileWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = context.radiusTokens;
    final styles = context.textStyles;
    // Define colors based on state
    final Color contentColor = widget.isActive
        ? theme.colorScheme.primary
        : _isHovering
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withValues(alpha: 0.7);

    final Color backgroundColor = widget.isActive
        ? theme.colorScheme.primary.withValues(alpha:0.1)
        : _isHovering
        ? theme.colorScheme.onSurface.withValues(alpha:0.05)
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: radius.all12,
          ),
          child: Row(
            children: [
              Icon(widget.data.icon, color: contentColor, size: 22.dp(context)),
              const SizedBox(width: 16),
              Text(
                widget.data.label,
                style: styles.bodyLargeTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: contentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}