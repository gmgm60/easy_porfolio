import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:easy_porfolio/features/dashboard/utils/drawer_item_type.dart';
 import 'package:easy_porfolio/features/dashboard/widgets/dashboard_top_bar_widget.dart';
import 'package:easy_porfolio/features/dashboard/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

class PortraitDashboardPage extends StatefulWidget {
  final StatefulNavigationShell shell;


  const PortraitDashboardPage({super.key, required this.shell});

  @override
  State<PortraitDashboardPage> createState() => _PortraitDashboardPageState();
}

class _PortraitDashboardPageState extends State<PortraitDashboardPage> {
  DrawerItemType get _current => indexToDrawerItem(widget.shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context).threshold;
    final isWide = size >= 900;
    final theme = Theme.of(context);

    return ZoomDrawer(
      menuScreen: Builder(
        builder: (context) {
          return MenuWidget(
            current: _current,
            onItemSelected: (item) {
              final index = DrawerItemType.values.indexOf(item);
              if (index != -1) {
                widget.shell.goBranch(index);
              }
              ZoomDrawer.of(context)?.close();
            },
          );
        },
      ),
      mainScreen: Scaffold(
        body: Padding(
          padding: const .all(10.0),
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return DashboardTopBarWidget(
                    onPressedMenu: () => ZoomDrawer.of(context)?.toggle(),
                  );
                }
              ),
              const SizedBox(height: 16),
              Expanded(child: widget.shell),
            ],
          ),
        ),
      ),
      borderRadius: 40.0,
      angle: -10,
      menuBackgroundColor: theme.scaffoldBackgroundColor,
      showShadow: true,
      openDragSensitivity: 1,
      openCurve: Curves.elasticInOut,
      closeCurve: Curves.easeInCubic,
      slideWidth: isWide ? size * 0.24 : size * 0.82,
      mainScreenTapClose: true,
    );
  }
}
