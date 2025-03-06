class Event {
  final int number;
  final String name;
  final String image;
  final String type;
  final String date;
  final String time;
  final String location;

  const Event({
    required this.number,
    required this.name,
    required this.image,
    required this.type,
    required this.date,
    required this.time,
    required this.location,
  });
}

const events = [
  Event(
    number: 1,
    name: 'Seniority Fest',
    image: 'event_banner.png',
    type: 'Music',
    date: '22 Februari 2025',
    time: '16.00 WITA',
    location: 'Parking Lot Phinisi Point: Makassar',
  ),
  Event(
    number: 2,
    name: 'ASSAC Vol. 7',
    image: 'event_banner.png',
    type: 'Music',
    date: '26 Oktober 2024',
    time: '19.30 WITA',
    location: 'Lapangan SMA Islam Al-Azhar 12: Makassar',
  ),
  Event(
    number: 3,
    name: 'Madani Art Show 8 (MARS 8)',
    image: 'event_banner.png',
    type: 'Music',
    date: '07 November 2024',
    time: '20.00 WITA',
    location: 'Gelora Bumi Kaktus Andi Raga Pettalolo: Palu',
  ),
  Event(
    number: 4,
    name: 'Characella',
    image: 'event_banner.png',
    type: 'Music',
    date: '18 Oktober 2024',
    time: '22.00 WITA',
    location: 'SMA Katolik Rajawali: Makassar',
  ),
  Event(
    number: 5,
    name: 'Atlantis Festival',
    image: 'event_banner.png',
    type: 'Music',
    date: '27 April 2024',
    time: '21.30 WITA',
    location: 'Parking Lot Phinisi Point: Makassar',
  ),
];
