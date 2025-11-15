import 'package:easy_porfolio/features/admin_home/utils/drawer_item_type.dart';
import 'package:easy_porfolio/features/dashboard/pages/dashborad_page.dart';
import 'package:easy_porfolio/features/dashboard/widgets/dashboard_top_bar_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.current});

  final DrawerItemType current;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 900;

    Widget child;
    switch (current) {
      case DrawerItemType.dashboard:
        child = const DashboardPage();
        break;
      case DrawerItemType.projects:
        child = const _PlaceholderPage(title: 'Projects');
        break;
      case DrawerItemType.messages:
        child = const _PlaceholderPage(title: 'Messages');
        break;
      case DrawerItemType.settings:
        child = const _PlaceholderPage(title: 'Settings');
        break;
    }

    return Scaffold(
       body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: isWide ? 520 : double.infinity,
             ),
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: isWide ? 24 : 16, vertical: 8),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const DashboardTopBarWidget(),
        const SizedBox(height: 32),
        Expanded(
          child: Center(
            child: Text(
              '$title page coming soon',
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
