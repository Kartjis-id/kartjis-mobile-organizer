enum DrawerMenuItem {
  dashboard('Dashboard', 'grid.svg'),
  eventDescription('Description', 'calendar.svg'),
  eventTalent('Talent/Artist', 'star.svg'),
  eventKartjis('Kartjis Detail', 'receipt.svg'),
  eventBuyer('Buyer Data', 'users-three.svg'),
  eventStaff('Sales Staff', 'identification-badge.svg'),
  eventReport('Sales Report', 'chart-bar.svg'),
  eventAgreement('Legal Agreement', 'handshake.svg'),
  eventInformation('Additional Information', 'info.svg'),
  withdrawal('Withdrawal', 'credit-card.svg'),
  service('Service', 'briefcase.svg'),
  organize('Organize', 'layers.svg'),
  support('Support', 'phone.svg');

  final String title;
  final String leadingIcon;

  const DrawerMenuItem(
    this.title,
    this.leadingIcon,
  );
}
