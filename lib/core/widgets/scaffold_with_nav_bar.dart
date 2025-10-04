
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_porfolio/features/theme/presentation/widgets/theme_switcher.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;
  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          context.go('/profile');
          break;
        case 1:
          context.go('/projects');
          break;
        case 2:
          context.go('/contact');
          break;
        case 3:
          context.go('/theme');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Portfolio'),
        actions: const [
          ThemeSwitcher(),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.folderOpen),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.envelope),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.palette),
            label: 'Theme',
          ),
        ],
      ),
    );
  }
}
