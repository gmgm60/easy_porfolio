import 'package:easy_porfolio/features/dashboard/utils/drawer_item_type.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  final DrawerItemType type;
  final IconData icon;
  final String label;

  const DrawerItem({
    required this.type,
    required this.icon,
    required this.label,
  });
}
