import 'package:flutter/material.dart';

class NumeroVirtuelScreen extends StatelessWidget {
  const NumeroVirtuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N° Virtuel'),
      ),
      body: const Center(
        child: Text('N° Virtuel Screen'),
      ),
    );
  }
}