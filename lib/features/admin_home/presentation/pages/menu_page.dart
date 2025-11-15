import 'package:easy_porfolio/core/widgets/animated_list_view_widget.dart';
import 'package:easy_porfolio/core/widgets/theme_switcher_widget.dart';
import 'package:easy_porfolio/features/admin_home/data/models/drawer_item.dart';
import 'package:easy_porfolio/features/admin_home/presentation/widgets/drawer_menu_tile_widget.dart';
import 'package:easy_porfolio/features/admin_home/presentation/widgets/menu_header_widget.dart';
import 'package:easy_porfolio/features/admin_home/utils/drawer_item_type.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required this.current,
    required this.onItemSelected,
  });

  final DrawerItemType current;
  final ValueChanged<DrawerItemType> onItemSelected;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _items = const [
    DrawerItem(type: DrawerItemType.dashboard, icon: Icons.dashboard_outlined, label: 'Dashboard'),
    DrawerItem(type: DrawerItemType.projects, icon: Icons.view_kanban_outlined, label: 'Projects'),
    DrawerItem(type: DrawerItemType.messages, icon: Icons.mail_outline, label: 'Messages'),
    DrawerItem(type: DrawerItemType.settings, icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280), // A more typical menu width
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const MenuHeaderWidget(
                name: 'Alex Doe',
                role: 'Portfolio Admin',
              ),
              const SizedBox(height: 32),
              Expanded(
                // Use the new general-purpose animated list
                child: AnimatedListViewWidget<DrawerItem>(
                  items: _items,
                  itemBuilder: (context, item, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: DrawerMenuTileWidget(
                          data: item,
                          isActive: widget.current == item.type,
                          onTap: () => widget.onItemSelected(item.type),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const ThemeSwitcherWidget(),
            ],
          ),
        ),
      ),
    );
  }
}