import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditCardTopup extends StatefulWidget {
  const CreditCardTopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreditCardTopupState createState() => _CreditCardTopupState();
}

class _CreditCardTopupState extends State<CreditCardTopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Retour',
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
      ),
      
    );
  }
}