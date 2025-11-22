
 import 'package:easy_porfolio/features/admin_home/presentation/widgets/root_zoom_drawer_widget.dart';
import 'package:easy_porfolio/features/auth/presentation/pages/admin_login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final adminRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AdminLoginPage(),
    ),
    GoRoute(
      path: '/Dashboard',
      builder: (context, state) => const RootZoomDrawerWidget(),
    ),
   ],
);
