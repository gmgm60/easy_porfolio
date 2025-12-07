import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DrawerItemType {
  dashboard(Icons.dashboard_outlined),
  projects(Icons.view_kanban_outlined),
  messages(Icons.mail_outline),
  settings(Icons.settings_outlined);

  final IconData icon;

  const DrawerItemType(this.icon);
}

// Helper to map the shell's index to our DrawerItemType enum
DrawerItemType indexToDrawerItem(int index) {
  return DrawerItemType.values[index];
}
