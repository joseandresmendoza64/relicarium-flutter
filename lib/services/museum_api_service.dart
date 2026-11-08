import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/museum_artwork.dart';

class MuseumApiService {
  static final endpoint = Uri.https(
    'api.artic.edu',
    '/api/v1/artworks/search',
    {
      'q': 'armor',
      'limit': '12',
      'fields': 'id,title,date_display,place_of_origin,image_id',
      'query[term][is_public_domain]': 'true',
    },
  );

  Future<List<MuseumArtwork>> fetchArtworks() async {
    final response = await http
        .get(endpoint, headers: {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw http.ClientException(
        'El museo respondió con HTTP ${response.statusCode}.',
        endpoint,
      );
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic> || decoded['data'] is! List) {
      throw const FormatException('La respuesta no contiene una lista de obras.');
    }

    final config = decoded['config'];
    final iiifBaseUrl =
        config is Map<String, dynamic> ? config['iiif_url'] as String? : null;
    final data = decoded['data'] as List;

    return data
        .map(
          (item) => MuseumArtwork.fromJson(
            item as Map<String, dynamic>,
            iiifBaseUrl: iiifBaseUrl,
          ),
        )
        .toList(growable: false);
  }
}