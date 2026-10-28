import 'package:flutter/material.dart';

import '../models/angkot_route.dart';

/// Card for one angkot route: bus image, code, route and fares.
class AngkotRouteCard extends StatelessWidget {
  const AngkotRouteCard({super.key, required this.route, this.onTap});

  final AngkotRoute route;
  final VoidCallback? onTap;

  static const _imageAsset = 'lib/assets/images/angkot/08A.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                SizedBox(
                  width: 124,
                  height: 72,
                  child: Image.asset(_imageAsset, fit: BoxFit.cover),
                ),
                const SizedBox(width: 39),
                Expanded(child: _RouteDetails(route: route)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RouteDetails extends StatelessWidget {
  const _RouteDetails({required this.route});

  final AngkotRoute route;

  static const _body = TextStyle(fontSize: 12, color: Colors.black);
  static const _title = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static String _rupiah(int value) => 'Rp. $value';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(route.code, style: _title),
        const SizedBox(height: 8),
        _LabeledRow(
          label: 'Rute :',
          child: Text(
            route.route,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _body,
          ),
        ),
        const SizedBox(height: 4),
        _LabeledRow(
          label: 'Tarif :',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 71,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Anak-anak', style: _body),
                    Text('Dewasa', style: _body),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_rupiah(route.childFare), style: _body),
                  Text(_rupiah(route.adultFare), style: _body),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 38,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
