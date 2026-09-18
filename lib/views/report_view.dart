import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedCategory;
  String? _attachmentName;

  static const _categories = [
    'Infrastruktur & Jalan',
    'Kebersihan & Sampah',
    'Kesehatan',
    'Pelayanan Publik',
    'Keamanan & Ketertiban',
    'Lainnya',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pengaduan berhasil dikirim')));
  }

  void _pickAttachment() {
    setState(() => _attachmentName = 'lampiran.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Form Pengaduan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sampaikan aspirasi, keluhan, atau laporan Anda secara '
                  'langsung demi meningkatkan kualitas layanan kami.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _AttachmentUploadBox(
                  attachmentName: _attachmentName,
                  onTap: _pickAttachment,
                ),
                const SizedBox(height: 16),
                _FieldLabel('Kategori Pengaduan'),
                const SizedBox(height: 8),
                _CategoryDropdownField(
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Judul Aduan'),
                const SizedBox(height: 8),
                _PengaduanTextField(
                  controller: _titleController,
                  hintText: 'Masukkan judul aduan',
                  icon: Icons.mail_outline,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Judul wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),
                _FieldLabel('Teks Aduan'),
                const SizedBox(height: 8),
                _PengaduanTextField(
                  controller: _bodyController,
                  hintText: 'Tuliskan Aduan',
                  icon: Icons.chat_bubble_outline,
                  maxLines: 5,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Isi aduan wajib diisi'
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kirim Aduan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }
}

/// Kotak dashed untuk upload lampiran foto.
class _AttachmentUploadBox extends StatelessWidget {
  const _AttachmentUploadBox({required this.onTap, this.attachmentName});

  final VoidCallback onTap;
  final String? attachmentName;

  @override
  Widget build(BuildContext context) {
    return DottedBorderBox(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 130,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF70787D).withOpacity(0.53)),
        ),
        alignment: Alignment.center,
        child: attachmentName != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  attachmentName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Upload',
                    style: TextStyle(fontSize: 12, color: Color(0xFF70787D)),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.image_outlined,
                    size: 19,
                    color: Color(0xFF70787D),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Border putus-putus di sekeliling area upload, sesuai desain Figma.
class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFF70787D),
          radius: 10,
        ),
        child: Container(
          height: 154,
          width: double.infinity,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}

/// Text field bergaya kartu putih dengan label icon di kiri, sesuai desain.
class _PengaduanTextField extends StatelessWidget {
  const _PengaduanTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(fontSize: 13, color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0x99000000)),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Icon(icon, size: 18, color: const Color(0x99000000)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// Dropdown kategori, mengikuti gaya visual field lainnya.
class _CategoryDropdownField extends StatelessWidget {
  const _CategoryDropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0x99000000)),
      style: const TextStyle(fontSize: 13, color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: 'Pilih Kategori',
        hintStyle: const TextStyle(fontSize: 12, color: Color(0x99000000)),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Icon(Icons.error_outline, size: 18, color: Color(0x99000000)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.24)),
        ),
      ),
      items: items
          .map(
            (category) =>
                DropdownMenuItem(value: category, child: Text(category)),
          )
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Kategori wajib dipilih' : null,
    );
  }
}
