import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dassi/screens/home/details/amount_widget.dart';
import 'package:logger/logger.dart';

class OrangeMoneyTopup extends StatefulWidget {
  const OrangeMoneyTopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrangeMoneyTopupState createState() => _OrangeMoneyTopupState();
}

class _OrangeMoneyTopupState extends State<OrangeMoneyTopup> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final Logger _logger = Logger();

  String _selectedCountry = 'CI'; // Code du pays par défaut
  String _selectedOperator = ''; // Opérateur sélectionné
  List<String> _operators = []; // Liste des opérateurs

  @override
  void initState() {
    super.initState();
    _loadOperators();
  }

  Future<void> _loadOperators() async {
    String apiClientId = 'bWt2Xy0bzFtf2OgLOwPSuve7Ma1I3xpc';
    String apiClientSecret = 'baUpGgQMHO-8xSO0Y0ZqCEusPbRty4-Vq0DxtoUGZO7UjYxJGvh5IOGNo31O8xe';
    String phoneNumber = _phoneNumberController.text;

    var operatorsUrl = Uri.parse('https://topups-sandbox.reloadly.com/operators/auto-detect/phone/$phoneNumber/countries/$_selectedCountry');
    var operatorsResponse = await http.get(operatorsUrl, headers: {
      'Authorization': 'Bearer $apiClientId:$apiClientSecret',
    });

    if (operatorsResponse.statusCode == 200) {
      var operators = jsonDecode(operatorsResponse.body);
      setState(() {
        _operators = operators['operators'].map<String>((op) => op['name']).toList();
      });
    } else {
      _logger.e('Erreur de détection des opérateurs : ${operatorsResponse.body}');
    }
  }

  Future<void> reloadlyTopup() async {
    String apiClientId = 'bWt2Xy0bzFtf2OgLOwPSuve7Ma1I3xpc';
    String apiClientSecret = 'baUpGgQMHO-8xSO0Y0ZqCEusPbRty4-Vq0DxtoUGZO7UjYxJGvh5IOGNo31O8xe';
    String phoneNumber = _phoneNumberController.text;
    double amount = double.parse(_amountController.text);

    var operatorsUrl = Uri.parse('https://topups-sandbox.reloadly.com/operators/auto-detect/phone/$phoneNumber/countries/$_selectedCountry');
    var operatorsResponse = await http.get(operatorsUrl, headers: {
      'Authorization': 'Bearer $apiClientId:$apiClientSecret',
    });

    if (operatorsResponse.statusCode == 200) {
      var operators = jsonDecode(operatorsResponse.body);
      var operator = operators['operators'].firstWhere((op) => op['name'] == _selectedOperator);

      var paymentUrl = Uri.parse('https://topups-sandbox.reloadly.com/topups');
      var paymentResponse = await http.post(paymentUrl, headers: {
        'Authorization': 'Bearer $apiClientId:$apiClientSecret',
        'Content-Type': 'application/json',
      }, body: jsonEncode({
        'operatorId': operator['operatorId'],
        'amount': amount.toString(),
        'useCase': 'topup',
        'senderId': phoneNumber,
      }));

      if (paymentResponse.statusCode == 200) {
        AmountWidgetController amountController = Get.find();
        amountController.updateWalletBalance(amount);
      } else {
        _logger.e('Erreur de paiement : ${paymentResponse.body}');
      }
    } else {
      _logger.e('Erreur de détection des opérateurs : ${operatorsResponse.body}');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Orange Money Topup'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCountry = newValue!;
              });
              _loadOperators();
            },
            items: ['CI', 'FR', 'US', /* Ajoutez d'autres codes de pays ici */]
                .map<DropdownMenuItem<String>>((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Numéro de téléphone',
              prefixText: '+$_selectedCountry ',
            ),
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          DropdownButtonFormField<String>(
            value: _selectedOperator,
            onChanged: (String? newValue) {
              setState(() {
                _selectedOperator = newValue!;
              });
            },
            items: _operators.map<DropdownMenuItem<String>>((String operator) {
              return DropdownMenuItem<String>(
                value: operator,
                child: Text(operator),
              );
            }).toList(),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Montant',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          ElevatedButton(
            onPressed: _selectedOperator.isNotEmpty && _amountController.text.isNotEmpty
                ? reloadlyTopup
                : null,
            child: const Text('Topup'),
          ),
        ],
      ),
    ),
  );
}
}