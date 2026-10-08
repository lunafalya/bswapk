import 'dart:convert';

import 'package:flutter/foundation.dart';

class NewsPost {
  const NewsPost({
    required this.id,
    required this.judul,
    required this.file,
    required this.kontenRaw,
    required this.status,
    required this.tglPublikasi,
    required this.slug,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String judul;
  final String? file;
  final String? kontenRaw;
  final String status;
  final DateTime? tglPublikasi;
  final String slug;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    debugPrint('KEYS: ${json.keys.toList()}');
    debugPrint('FILE: ${json['file']}');
    return NewsPost(
      id: _asInt(json['id']),
      judul: (json['judul']?.toString() ?? '').trim().isEmpty
          ? '(Tanpa judul)'
          : json['judul'].toString().trim(),
      file: json['file']?.toString(),
      kontenRaw: json['konten']?.toString() ?? json['isi']?.toString(),
      status: json.containsKey('status') ? json['status'].toString() : '',
      tglPublikasi: _asDate(json['tgl_publikasi'] ?? json['tanggal']),
      slug:
          (json['slug'] ??
                  json['slugpost'] ??
                  json['id'] ??
                  json['postid'] ??
                  '')
              .toString(),
      userId: json['user_id'] == null ? null : _asInt(json['user_id']),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _asDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  bool get isPublished => status.isEmpty || int.tryParse(status) == 1;

  static const _imageBase = 'https://kotabogor.go.id/uploads/berita';

  String? get imageUrl {
    final raw = file;
    if (raw == null || raw.isEmpty) return null;

    String candidate = raw;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List && decoded.isNotEmpty) {
        candidate = decoded.first.toString();
      }
    } catch (_) {}

    if (candidate.isEmpty) return null;

    if (candidate.startsWith('http://') || candidate.startsWith('https://')) {
      return candidate;
    }
    return '${_imageBase.replaceAll(RegExp(r'/+$'), '')}/${candidate.replaceAll(RegExp(r'^/+'), '')}';
  }

  String get konten {
    final raw = kontenRaw ?? '';
    final noTags = raw.replaceAll(RegExp(r'<[^>]*>'), ' ');
    final unescaped = _unescapeHtmlEntities(noTags);
    return unescaped.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String _unescapeHtmlEntities(String input) {
    return input
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'");
  }

  String get ringkas {
    final k = konten;
    if (k.length <= 140) return k;
    return '${k.substring(0, 140).trimRight()}...';
  }

  List<String> get paragraphs {
    final k = konten;
    if (k.isEmpty) return const [];
    return k
        .split(RegExp(r'(?<=[.!?])\s+(?=[A-Z])'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
  }

  String get tanggal {
    final date = tglPublikasi ?? createdAt;
    if (date == null) return '';
    const bulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final tanggalStr = '${date.day} ${bulan[date.month - 1]} ${date.year}';
    final punyaJam = date.hour != 0 || date.minute != 0;
    if (!punyaJam) return tanggalStr;
    final jam = date.hour.toString().padLeft(2, '0');
    final menit = date.minute.toString().padLeft(2, '0');
    return '$tanggalStr, $jam:$menit WIB';
  }

  String get timeAgo {
    final date = tglPublikasi ?? createdAt;
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 30) return '${diff.inDays} hari lalu';
    return tanggal;
  }
}
