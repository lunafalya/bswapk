import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_post.dart';
import '../config/secrets.dart';

class NewsService {
  NewsService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _apiUrl = Secrets.beritaApiUrl;
  static const _apiKeyHeader = Secrets.beritaApikey;
  static const _apiKeyQuery = Secrets.beritaApiKey;

  Future<List<NewsPost>> fetchNews() async {
    if (_apiUrl.isEmpty || _apiKeyHeader.isEmpty) {
      throw Exception(
        'BERITA_API_URL / BERITA_APIKEY belum di-set. '
        'Jalankan dengan --dart-define, lihat komentar di news_service.dart.',
      );
    }

    final uri = Uri.parse(_apiUrl).replace(
      queryParameters: _apiKeyQuery.isNotEmpty ? {'key': _apiKeyQuery} : null,
    );

    final response = await _client.get(
      uri,
      headers: {'accept': '*/*', 'apikey': _apiKeyHeader},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil berita (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);

    final List<dynamic> rawList;
    if (decoded is Map<String, dynamic> && decoded['Berita Bogor'] is List) {
      rawList = decoded['Berita Bogor'] as List;
    } else if (decoded is Map<String, dynamic> && decoded['data'] is List) {
      rawList = decoded['data'] as List;
    } else if (decoded is List) {
      rawList = decoded;
    } else {
      rawList = const [];
    }

    final posts = rawList
        .whereType<Map<String, dynamic>>()
        .map(NewsPost.fromJson)
        .where((p) => p.isPublished)
        .toList();

    posts.sort((a, b) {
      final da = a.tglPublikasi ?? a.createdAt;
      final db = b.tglPublikasi ?? b.createdAt;
      if (da == null || db == null) return 0;
      return db.compareTo(da); // terbaru dulu
    });

    return posts;
  }

  Future<NewsPost?> findBySlug(String slug) async {
    final posts = await fetchNews();
    for (final post in posts) {
      if (post.slug == slug) return post;
    }
    return null;
  }

  void dispose() => _client.close();
}
