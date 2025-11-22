 import 'package:easy_porfolio/core/widgets/animated_size_visibility.dart';
import 'package:easy_porfolio/features/dashboard/utils/drawer_item_type.dart';
 import 'package:easy_porfolio/features/dashboard/widgets/dashboard_top_bar_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandscapeDashboardPage extends StatefulWidget {
  final StatefulNavigationShell shell;

  const LandscapeDashboardPage({super.key, required this.shell});

  @override
  State<LandscapeDashboardPage> createState() => _LandscapeDashboardPageState();
}

class _LandscapeDashboardPageState extends State<LandscapeDashboardPage> {
  bool _showMenu = true;

  @override
  Widget build(BuildContext context) {
    final currentItem = indexToDrawerItem(widget.shell.currentIndex);
    return Scaffold(
      body:  Row(
        spacing: 5,
        children: [
             Expanded(

              child: AnimatedSizeVisibility(
                isVisible: _showMenu,
                child: MenuWidget(
                  current: currentItem,
                  onItemSelected: (item) {
                    final index = DrawerItemType.values.indexOf(item);
                    if (index != -1) {
                      widget.shell.goBranch(index);
                    }
                  },
                ),
              ),
            ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const .all(10.0),
                child: Column(
                  children: [
                    DashboardTopBarWidget(
                      onPressedMenu: () => setState(() {
                        _showMenu = !_showMenu;
                      }),
                    ),
                    const SizedBox(height: 16),
                    Expanded(child: widget.shell),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
