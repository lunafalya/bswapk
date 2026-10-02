import 'dart:convert';

/// Model satu berita, field mentah persis kolom tabel di API:
/// id, judul, file, konten, status, tgl_publikasi, slug, user_id,
/// created_at, updated_at.
///
/// Aturan normalisasinya sengaja disamakan dengan `BeritaService::normalize()`
/// di web (Laravel) supaya app & web menampilkan data yang konsisten:
/// - `key` (dipakai buat identitas/URL detail) = slug ?? slugpost ?? id ?? postid
/// - `status` cuma dianggap terbit kalau nilainya 1 (int), atau field-nya
///   memang tidak ada sama sekali (berarti API sudah memfilter sendiri)
/// - `konten` itu HTML mentah -> di-strip dulu buat ditampilkan sebagai teks
///   polos (paragraf) di halaman list/ringkasan
/// - `file` bisa URL penuh, nama file doang, atau string JSON list gambar
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

  /// HTML mentah dari API — JANGAN ditampilkan langsung ke Text widget,
  /// pakai [konten]/[paragraphs] (sudah di-strip) atau render pakai
  /// `flutter_html` di halaman detail kalau butuh formatting aslinya.
  final String? kontenRaw;
  final String status;
  final DateTime? tglPublikasi;
  final String slug;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    return NewsPost(
      id: _asInt(json['id']),
      judul: (json['judul']?.toString() ?? '').trim().isEmpty
          ? '(Tanpa judul)'
          : json['judul'].toString().trim(),
      file: json['file']?.toString(),
      kontenRaw: json['konten']?.toString() ?? json['isi']?.toString(),
      // Sama seperti web: kalau field status nggak ada, dianggap "lolos"
      // (nilai string kosong nanti dicek khusus di `isPublished`).
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

  /// true kalau berita ini terbit — sama seperti filter di BeritaService.php:
  /// `!array_key_exists('status', $row) || (int) $row['status'] === 1`.
  bool get isPublished => status.isEmpty || int.tryParse(status) == 1;

  /// Ganti dengan base URL asset/file server BSW yang sebenarnya kalau
  /// `file` bukan URL lengkap. Di web ini datang dari
  /// `config('services.berita.image_base')` — belum dibagikan nilainya,
  /// jadi TODO: isi sesuai `.env` (`BERITA_IMAGE_BASE` atau sejenisnya).
  static const _imageBase = 'TODO_ISI_IMAGE_BASE_URL_DARI_ENV';

  /// URL gambar final. Field `file` bisa: URL penuh, nama file doang,
  /// atau string berisi JSON list (ambil elemen pertama) — sama seperti
  /// `gambarUrl()` di BeritaService.php.
  String? get imageUrl {
    final raw = file;
    if (raw == null || raw.isEmpty) return null;

    // Kalau `file` ternyata JSON list, ambil elemen pertamanya.
    String candidate = raw;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List && decoded.isNotEmpty) {
        candidate = decoded.first.toString();
      }
    } catch (_) {
      // bukan JSON, biarkan apa adanya.
    }

    // `candidate` selalu non-null (String, bukan String?) sampai sini,
    // jadi tinggal cek kosong-nya saja — tidak perlu null-check lagi.
    if (candidate.isEmpty) return null;

    if (candidate.startsWith('http://') || candidate.startsWith('https://')) {
      return candidate;
    }
    return '${_imageBase.replaceAll(RegExp(r'/+$'), '')}/${candidate.replaceAll(RegExp(r'^/+'), '')}';
  }

  /// `konten` setelah HTML tag & spasi ganda dibuang — sama seperti
  /// `strip_tags` + `html_entity_decode` + normalisasi spasi di web.
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

  /// Ringkasan pendek — versi mobile dari `Str::limit($konten, 140)` di web.
  String get ringkas {
    final k = konten;
    if (k.length <= 140) return k;
    return '${k.substring(0, 140).trimRight()}...';
  }

  /// Pecah `konten` jadi list paragraf, dipakai NewsDetailView.
  /// TODO: kalau butuh formatting HTML asli (bold, list, gambar inline)
  /// di halaman detail, render `kontenRaw` pakai package `flutter_html`
  /// alih-alih pakai getter ini.
  List<String> get paragraphs {
    final k = konten;
    if (k.isEmpty) return const [];
    return k
        .split(RegExp(r'(?<=[.!?])\s+(?=[A-Z])'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
  }

  /// "24 Okt 2024" / "24 Okt 2024, 14:30 WIB" — mirip `formatTanggal()` di web.
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

  /// Teks relatif "X jam/hari lalu", dipakai di kartu carousel mobile
  /// (web pakai tanggal absolut, tapi ini lebih pas buat UI mobile).
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
