import 'package:flutter/material.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency')),
      body: Center(child: Text('Emergency Content')),
    );
  }
}
