class MuseumArtwork {
  const MuseumArtwork({
    required this.id,
    required this.title,
    this.date,
    this.origin,
    this.imageId,
    this.imageUrl,
  });

  final int id;
  final String title;
  final String? date;
  final String? origin;
  final String? imageId;
  final String? imageUrl;

  factory MuseumArtwork.fromJson(
    Map<String, dynamic> json, {
    String? iiifBaseUrl,
  }) {
    final imageId = json['image_id'] as String?;

    return MuseumArtwork(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date_display'] as String?,
      origin: json['place_of_origin'] as String?,
      imageId: imageId,
      imageUrl: imageId != null && iiifBaseUrl != null
          ? '$iiifBaseUrl/$imageId/full/400,/0/default.jpg'
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date_display': date,
    'place_of_origin': origin,
    'image_id': imageId,
  };
}