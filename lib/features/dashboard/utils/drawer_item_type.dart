enum DrawerItemType {
  dashboard,
  projects,
  messages,
  settings,
}


// Helper to map the shell's index to our DrawerItemType enum
DrawerItemType indexToDrawerItem(int index) {
  switch (index) {
    case 0:
      return DrawerItemType.dashboard;
    case 1:
      return DrawerItemType.projects;
    case 2:
      return DrawerItemType.messages;
    case 3:
      return DrawerItemType.settings;
    default:
      return DrawerItemType.dashboard;
  }
}
