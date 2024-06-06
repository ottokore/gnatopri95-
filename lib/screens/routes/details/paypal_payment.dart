import 'package:flutter/material.dart';

class PaypalPayment extends StatefulWidget {
  const PaypalPayment({ super.key, required this.amount, required this.currency });
  final double amount;
  final String currency;

  @override
  // ignore: library_private_types_in_public_api
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      )
    );
  }
}