import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';

// Colors taken from the web page (Tailwind slate palette + BSW navy/teal).
const _navy = Color(0xFF142450);
const _teal = Color(0xFF4BB7A8);
const _pageBg = Color(0xFFF8FAFC);
const _slate100 = Color(0xFFF1F5F9);
const _slate200 = Color(0xFFE2E8F0);
const _slate400 = Color(0xFF94A3B8);
const _slate600 = Color(0xFF475569);
const _slate800 = Color(0xFF1E293B);

/// One FAQ entry. Use `**bold**` and `*italic*` inside [paragraph]/[steps].
class _FaqEntry {
  const _FaqEntry({
    required this.question,
    this.paragraph,
    this.steps = const [],
  });

  final String question;
  final String? paragraph;
  final List<String> steps;
}

const _faqs = <_FaqEntry>[
  _FaqEntry(
    question: 'Bagaimana cara mendaftar akun SSO di BSW?',
    steps: [
      'Klik tombol **Daftar Disini** atau **Daftar Akun Baru**.',
      'Masukkan NIK dan klik **Cek NIK**.',
      'Isi data diri dengan lengkap.',
      'Klik **Selanjutnya**.',
      'Isi alamat dengan lengkap.',
      'Klik **Selanjutnya**.',
      'Cek kembali data pendaftaran Anda, centang pernyataan kebenaran data, '
          'lalu klik **Selesai**.',
      'Pendaftaran berhasil! Jika ada notifikasi *\'Email belum diaktivasi\'*, '
          'cek inbox atau spam email.',
      'Pada email aktivasi, klik tombol **Aktivasi Akun**.',
      'Akun Anda telah berhasil diaktivasi.',
      'Silakan kembali ke halaman login, atau klik tombol **Login Disini**.',
      'Masukkan email dan kata sandi yang telah didaftarkan, lalu klik '
          '**Masuk**.',
    ],
  ),
  _FaqEntry(
    question: 'Apa itu Bogor Single Window (BSW)?',
    paragraph:
        'Bogor Single Window (BSW) adalah portal integrasi satu pintu resmi '
        'Pemerintah Kota Bogor yang menyediakan kemudahan akses terhadap '
        'beragam layanan publik digital, informasi kota, fasilitas umum, dan '
        'layanan kedaruratan bagi seluruh masyarakat serta aparatur sipil '
        'negara (ASN).',
  ),
  _FaqEntry(
    question: 'Bagaimana jika saya lupa kata sandi?',
    steps: [
      'Klik menu **Lupa Password?** pada halaman login BSW.',
      'Sistem akan mengarahkan Anda ke portal login SSO Kota Bogor.',
      'Pada halaman tersebut, pilih menu **Reset Password**.',
      'Ketikkan salah satu identitas Anda (NIK, NIP, Email, atau No. '
          'WhatsApp).',
      'Pilih metode pengiriman instruksi reset (WhatsApp atau Email).',
      'Masukkan kode verifikasi Captcha yang tersedia di layar.',
      'Tekan tombol **Reset Password** dan periksa pesan masuk pada metode '
          'yang Anda pilih.',
    ],
  ),
  _FaqEntry(
    question: 'Bagaimana cara login akun SSO di BSW?',
    steps: [
      'Pada halaman login BSW, ketikkan Email, nomor handphone, atau nomor '
          'WhatsApp yang telah didaftarkan.',
      'Masukkan kata sandi akun Anda.',
      'Ketikkan kode Captcha yang tampil pada layar.',
      'Klik tombol **Masuk**.',
    ],
  ),
];

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpState();
}

class _HelpState extends State<HelpView> {
  // Like the web page, items open/close independently; the first starts open.
  final Set<int> _openItems = {0};

  void _toggle(int index) {
    setState(() {
      if (!_openItems.remove(index)) _openItems.add(index);
    });
  }

  Future<void> _openLiveChat() async {
    final uri = Uri.https('api.whatsapp.com', '/send', {
      'phone': '6281122882233',
      'text': 'Halo, saya ingin bertanya tentang layanan BSW',
    });
    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      appBar: AppBar(
        backgroundColor: _pageBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: _slate800),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          const _FaqHeader(),
          const SizedBox(height: 32),
          for (var i = 0; i < _faqs.length; i++) ...[
            _FaqAccordionItem(
              entry: _faqs[i],
              isOpen: _openItems.contains(i),
              onToggle: () => _toggle(i),
            ),
            if (i != _faqs.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openLiveChat,
        backgroundColor: _teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        icon: const Icon(Icons.chat_bubble_outline, size: 18),
        label: const Text(
          'Live Chat',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _FaqHeader extends StatelessWidget {
  const _FaqHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Frequently Asked Questions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            color: _slate800,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Selamat datang! Temukan jawaban atas pertanyaan umum terkait '
          'layanan Bogor Single Window (BSW) di sini. Kami siap membantu Anda.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.6, color: _slate600),
        ),
      ],
    );
  }
}

class _FaqAccordionItem extends StatelessWidget {
  const _FaqAccordionItem({
    required this.entry,
    required this.isOpen,
    required this.onToggle,
  });

  final _FaqEntry entry;
  final bool isOpen;
  final VoidCallback onToggle;

  static const _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _slate200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          AnimatedSize(
            duration: _duration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isOpen
                ? _buildBody()
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: _duration,
      color: isOpen ? _navy : Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: _duration,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isOpen ? Colors.white : _slate800,
                    ),
                    child: Text(entry.question),
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: _duration,
                  child: Icon(
                    Icons.expand_more,
                    size: 22,
                    color: isOpen ? Colors.white : _slate400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _slate100)),
      ),
      child: entry.paragraph != null
          ? _FormattedText(entry.paragraph!)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < entry.steps.length; i++) ...[
                  _NumberedStep(number: i + 1, text: entry.steps[i]),
                  if (i != entry.steps.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28,
          child: Text(
            '$number.',
            style: const TextStyle(fontSize: 14, height: 1.6, color: _slate600),
          ),
        ),
        Expanded(child: _FormattedText(text)),
      ],
    );
  }
}

/// Renders `**bold**` and `*italic*` markers inside a text line.
class _FormattedText extends StatelessWidget {
  const _FormattedText(this.text);

  final String text;

  static final _pattern = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*');
  static const _base = TextStyle(fontSize: 14, height: 1.6, color: _slate600);

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[];
    var cursor = 0;

    for (final match in _pattern.allMatches(text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, match.start)));
      }
      if (match.group(1) != null) {
        spans.add(
          TextSpan(
            text: match.group(1),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: _slate800,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: match.group(2),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      }
      cursor = match.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }

    return Text.rich(TextSpan(style: _base, children: spans));
  }
}
