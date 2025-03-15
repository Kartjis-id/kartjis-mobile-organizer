class Event {
  final String name;
  final String image;
  final String type;
  final String date;
  final String time;
  final String location;

  const Event({
    required this.name,
    required this.image,
    required this.type,
    required this.date,
    required this.time,
    required this.location,
  });
}

const event = Event(
  name: 'Madani Art Show 8',
  image: 'event_banner.png',
  type: 'Music',
  date: '31 Desember 2024',
  time: '20.00 WITA',
  location: 'Parking Lot Phipo Mall, Makassar',
);
