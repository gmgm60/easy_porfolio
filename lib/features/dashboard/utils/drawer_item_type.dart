enum DrawerItemType { dashboard, projects, messages, settings }

// Helper to map the shell's index to our DrawerItemType enum
DrawerItemType indexToDrawerItem(int index) {
  if (index >= 0 && index < DrawerItemType.values.length) {
    return DrawerItemType.values[index];
  }
  return DrawerItemType.dashboard;
}
