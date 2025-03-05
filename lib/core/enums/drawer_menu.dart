enum DrawerMenu {
  dashboard('Dashboard', 'grid.svg'),
  eventLiveReport('Live Report', 'radio.svg'),
  eventDescription('Description', 'calendar.svg'),
  eventTalent('Talent', 'star.svg'),
  eventKartjis('Kartjis', 'receipt.svg'),
  eventCustomer('Customer', 'users_three.svg'),
  eventStaff('Staff', 'identification_badge.svg'),
  eventReport('Report', 'chart_bar.svg'),
  eventAgreement('Agreement', 'handshake.svg'),
  eventInformation('Information', 'info.svg'),
  withdrawal('Withdrawal', 'credit_card.svg'),
  service('Service', 'briefcase.svg'),
  organize('Organize', 'layers.svg'),
  support('Support', 'phone.svg');

  final String title;
  final String leadingIcon;

  const DrawerMenu(
    this.title,
    this.leadingIcon,
  );
}
