import 'package:easy_porfolio/core/utils/screen_size.dart';
import 'package:easy_porfolio/features/dashboard/pages/landscape_dashboard_page.dart';
import 'package:easy_porfolio/features/dashboard/pages/portrait_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveDashboardScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ResponsiveDashboardScaffold({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =getScreenSize(context).threshold > 600;

    if (isLandscape) {
      return LandscapeDashboardPage(shell: navigationShell);
    } else {

      return PortraitDashboardPage(shell: navigationShell);
    }
  }
}
