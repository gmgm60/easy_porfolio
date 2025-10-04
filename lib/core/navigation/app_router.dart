
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_porfolio/features/onboarding/presentation/onboarding_screen.dart';
import 'package:easy_porfolio/core/widgets/scaffold_with_nav_bar.dart';
import 'package:easy_porfolio/features/profile/presentation/profile_screen.dart';
import 'package:easy_porfolio/features/projects/presentation/projects_screen.dart';
import 'package:easy_porfolio/features/contact/presentation/contact_screen.dart';
import 'package:easy_porfolio/features/projects/presentation/project_details_screen.dart';
import 'package:easy_porfolio/features/theme/presentation/theme_screen.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return ProjectDetailsScreen(projectId: id);
              },
            ),
          ]
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(
          path: '/theme',
          builder: (context, state) => const ThemeScreen(),
        ),
      ],
    ),
  ],
);
