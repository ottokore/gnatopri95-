import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
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