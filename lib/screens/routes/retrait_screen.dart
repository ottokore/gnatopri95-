import 'package:flutter/material.dart';

class RetraitScreen extends StatelessWidget {
  const RetraitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrait'),
      ),
      body: const Center(
        child: Text('Retrait Screen'),
      ),
    );
  }
}