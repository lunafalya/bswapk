import 'package:flutter/material.dart';

import '../../models/tax_bill.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tax/tax_bill_result_card.dart';
import '../../widgets/tax/tax_check_field.dart';

class TagihanView extends StatefulWidget {
  const TagihanView({super.key});

  @override
  State<TagihanView> createState() => _TagihanViewState();
}

class _TagihanViewState extends State<TagihanView> {
  final _nopController = TextEditingController();
  final _nopolController = TextEditingController();

  bool _isCheckingNop = false;
  bool _isCheckingNopol = false;

  TaxBillResult? _pbbResult;
  TaxBillResult? _pkbResult;

  int _currentNavIndex = 1;

  @override
  void dispose() {
    _nopController.dispose();
    _nopolController.dispose();
    super.dispose();
  }

  Future<void> _handleCekNop() async {
    if (_nopController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan NOP terlebih dahulu')),
      );
      return;
    }

    setState(() {
      _isCheckingNop = true;
      _pbbResult = null;
    });

    // API pengecekan PBB berdasarkan NOP.
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() {
      _isCheckingNop = false;
      _pbbResult = const TaxBillResult(
        categoryLabel: 'PBB',
        statusLabel: 'Non-PBI',
        ownerName: 'Nama Pengguna',
        idNumber: '3135327321047634',
        objectTypeLabel: 'Rumah Tetap',
        amountLabel: 'Rp. 100.000,00',
        addressLabel: 'Ruko Blok BII No. 9–10, Cluster Amparan Jati, Pakuan Regency, Kota Bogor',
        extraInfoLabel: '500m2/300 m2',
        payButtonLabel: 'Bayar Sekarang di e-SPPT Bogor',
      );
    });
  }

  Future<void> _handleCekNopol() async {
    if (_nopolController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan NOPOL terlebih dahulu')),
      );
      return;
    }

    setState(() {
      _isCheckingNopol = true;
      _pkbResult = null;
    });

    // TODO: ganti dengan pemanggilan API pengecekan PKB berdasarkan NOPOL.
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() {
      _isCheckingNopol = false;
      _pkbResult = const TaxBillResult(
        categoryLabel: 'PKB',
        statusLabel: 'Non-PBI',
        ownerName: 'Nama Pengguna',
        idNumber: 'F 1234 ABC',
        objectTypeLabel: 'Mobil Pribadi',
        amountLabel: 'Rp. 350.000,00',
        addressLabel: 'Honda Brio Satya E 2021, Warna Putih',
        extraInfoLabel: 'Jatuh tempo 12/2026',
        payButtonLabel: 'Bayar Sekarang di e-Samsat Jabar',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  const Text(
                    'Cek Tagihan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Periksa status dan nominal pajak aktif seperti Pajak Bumi dan '
                    'Bangunan (PBB) atau Pajak Kendaraan Bermotor (PKB).',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Field 1: NOP -> hasil PBB
                  TaxCheckField(
                    label: 'Nomor Objek Pajak (NOP)',
                    hint: 'Masukkan NOP Anda',
                    controller: _nopController,
                    onCek: _handleCekNop,
                    isLoading: _isCheckingNop,
                  ),
                  if (_pbbResult != null) ...[
                    const SizedBox(height: 20),
                    TaxBillResultCard(result: _pbbResult!, onPay: () {}),
                  ],

                  const SizedBox(height: 24),

                  TaxCheckField(
                    label: 'Nomor Polisi (Nopol / Plat Nomor)',
                    hint: 'Masukkan NOPOL Anda',
                    controller: _nopolController,
                    onCek: _handleCekNopol,
                    isLoading: _isCheckingNopol,
                  ),
                  if (_pkbResult != null) ...[
                    const SizedBox(height: 20),
                    TaxBillResultCard(result: _pkbResult!, onPay: () {}),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 1, 20, 25),
            ),
          ),
        ],
      ),
    );
  }
}
