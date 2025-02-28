enum DrawerMenuItem {
  liveReport('Live Report', 'radio_outlined.svg'),
  dashboard('Dashboard', 'grid_outlined.svg'),
  event('Event', 'calendar_outlined.svg'),
  withdrawal('Withdrawal', 'credit_card_outlined.svg'),
  service('Service', 'briefcase_outlined.svg'),
  organize('Organize', 'layers_outlined.svg'),
  support('Support', 'phone_outlined.svg');

  final String title;
  final String leadingIcon;

  const DrawerMenuItem(
    this.title,
    this.leadingIcon,
  );
}
