enum DrawerMenuItem {
  dashboard('Dashboard', 'grid.svg'),
  eventLiveReport('Live Report', 'radio.svg'),
  eventDescription('Description', 'calendar.svg'),
  eventTalent('Talent', 'star.svg'),
  eventKartjis('Kartjis', 'receipt.svg'),
  eventCustomer('Customer', 'users-three.svg'),
  eventStaff('Staff', 'identification-badge.svg'),
  eventReport('Report', 'chart-bar.svg'),
  eventAgreement('Agreement', 'handshake.svg'),
  eventInformation('Information', 'info.svg'),
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
