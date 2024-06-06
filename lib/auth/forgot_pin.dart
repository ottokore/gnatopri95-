import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgotPin extends StatefulWidget {
  const ForgotPin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPinState createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réinitialiisation', style: TextStyle(color: primaryColor, fontSize: 18),),
      ),
      body: const Center(
        child: Text('Mot de passe oublié ?'),
      ),
    );
  }
}