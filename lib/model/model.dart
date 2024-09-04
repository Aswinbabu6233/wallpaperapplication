class images {
  final int imageID;
  final String imageAlt;
  final String imagePotraitPath;

  const images({
    required this.imageAlt,
    required this.imageID,
    required this.imagePotraitPath,
  });

  factory images.fromJson(Map<String, dynamic> json) => images(
      imageAlt: json['alt'] as String,
      imageID: json['id'] as int,
      imagePotraitPath: json['src']['portrait'] as String);

  images.emptyConstructor(
      {this.imageAlt = '', this.imageID = 0, this.imagePotraitPath = ''});
}
