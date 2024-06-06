import 'package:flutter/material.dart';

class FactureScreen extends StatelessWidget {
  const FactureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facture'),
      ),
      body: const Center(
        child: Text('Facture Screen'),
      ),
    );
  }
}