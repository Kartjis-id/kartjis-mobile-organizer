enum EventImageType {
  thumbnail('Thumbnail', 4 / 3),
  slide('Slide', 16 / 5),
  detail('Detail', 16 / 9);

  final String name;
  final double aspectRatio;

  const EventImageType(
    this.name,
    this.aspectRatio,
  );
}
