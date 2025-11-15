import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:easy_porfolio/features/admin_home/presentation/pages/main_page.dart';
import 'package:easy_porfolio/features/admin_home/presentation/pages/menu_page.dart';
import 'package:easy_porfolio/features/admin_home/utils/drawer_item_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class RootZoomDrawerWidget extends StatefulWidget {
  const RootZoomDrawerWidget({super.key});

  @override
  State<RootZoomDrawerWidget> createState() => _RootZoomDrawerWidgetState();
}

class _RootZoomDrawerWidgetState extends State<RootZoomDrawerWidget> {
  DrawerItemType _current = DrawerItemType.dashboard;

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context).threshold;
    final isWide = size >= 900;
     final theme = Theme.of(context);

    return ZoomDrawer(
      menuScreen: Builder(
        builder: (context) {
          return MenuPage(
            current: _current,
            onItemSelected: (item) {
              setState(() => _current = item);
              ZoomDrawer.of(context)?.close();
            },
          );
        }
      ),
      mainScreen: MainPage(current: _current),
       borderRadius: 40.0,
        angle:  -10,
       menuBackgroundColor:theme.scaffoldBackgroundColor,
       showShadow: true,
         openDragSensitivity: 1,
       openCurve: Curves.elasticInOut,
      closeCurve: Curves.easeInCubic,
      slideWidth: isWide ? size * 0.24 : size * 0.82,
        mainScreenTapClose: true,
    );
  }
}


