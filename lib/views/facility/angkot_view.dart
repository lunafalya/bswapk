import 'package:flutter/material.dart';

import '../../models/angkot_route.dart';
import '../../widgets/angkot_route_card.dart';

class AngkotView extends StatelessWidget {
  const AngkotView({super.key});

  // Placeholder data from the design. Replace with API/DB data later.
  static final List<AngkotRoute> _routes = List.generate(
    6,
    (_) => const AngkotRoute(
      code: '08 A',
      route: 'Bogor Baru - Jambu Dua',
      childFare: 4000,
      adultFare: 5000,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _BackButtonBar(),
            const _Header(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(17, 16, 17, 24),
                itemCount: _routes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 11),
                itemBuilder: (_, index) =>
                    AngkotRouteCard(route: _routes[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButtonBar extends StatelessWidget {
  const _BackButtonBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            iconSize: 16,
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'RUTE ANGKOT KOTA BOGOR',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 312),
          child: Text(
            'Isi Deskripsi Dari Fitur Rute Angkot Yang Menampilkan '
            'Informasi Singkat Mengenai Rute',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
