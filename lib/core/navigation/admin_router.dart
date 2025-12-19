 import 'package:easy_porfolio/features/auth/presentation/pages/admin_login_page.dart';
import 'package:easy_porfolio/features/dashboard/pages/dashborad_page.dart';
import 'package:easy_porfolio/features/dashboard/pages/placeholder_page.dart';
import 'package:easy_porfolio/features/dashboard/pages/responsive_dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final adminRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login', // Good practice to name the initial route
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const AdminLoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ResponsiveDashboardScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(
            debugLabel: 'dashboardBranch',
          ),
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
              // Add sub-routes here if needed, e.g., '/dashboard/details'
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'ProjectBranch'),
          routes: [
            GoRoute(
              path: '/Projects',
              builder: (context, state) =>
                  const PlaceholderPage(title: 'Projects'),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'projectsBranch'),
          routes: [
            GoRoute(
              path: '/Messages',
              builder: (context, state) =>
                  const PlaceholderPage(title: 'Messages'),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'contactBranch'),
          routes: [
            GoRoute(
              path: '/Settings',
              builder: (context, state) =>
                  const PlaceholderPage(title: 'Settings'),
            ),
          ],
        ),
      ],
    ),
  ],
);
