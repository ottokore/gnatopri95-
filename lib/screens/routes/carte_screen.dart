import 'dart:math';
import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class CarteScreen extends StatefulWidget {
  const CarteScreen({super.key});

  @override
  State<CarteScreen> createState() => _CarteScreenState();
}

class _CarteScreenState extends State<CarteScreen> {
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  double _balance = 1000.0; // Solde initial du portefeuille
  double _amount = 0.0;
  String _errorMessage = '';
  final List<Map<String, String>> _generatedCards = [];

  @override
  void initState() {
    super.initState();
    _generateCardDetails();
  }

  void _generateCardDetails() {
    // Génération du numéro de carte Visa
    final random = Random();
    final digits = List.generate(16, (_) => random.nextInt(10));
    digits[0] = 4; // Le numéro Visa commence toujours par 4
    _cardNumber = digits.join();

    // Génération de la date d'expiration
    final currentYear = DateTime.now().year;
    final expiryYear = currentYear + 3;
    final expiryMonth = random.nextInt(12) + 1;
    _expiryDate = '${expiryMonth.toString().padLeft(2, '0')}/${(expiryYear % 100).toString().padLeft(2, '0')}';

    // Génération du CVV
    _cvv = (random.nextInt(900) + 100).toString();
  }

  void _generateCard() {
    if (_amount >= 10) {
      if (_amount <= _balance) {
        _balance -= _amount;
        Map<String, String> newCard = {
          'cardNumber': _cardNumber,
          'expiryDate': _expiryDate,
          'cvv': _cvv,
        };
        _generatedCards.add(newCard);
        _generateCardDetails();
        _errorMessage = '';
        setState(() {});
      } else {
        _errorMessage = "Solde insuffisant dans votre portefeuille.";
      }
    } else {
      _errorMessage = "Le montant doit être d'au moins 10 euros.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Retour',
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
        backgroundColor: bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(
              top: h * 0.01,
            )),
            Text(
              "Générer ma carte de crédit",
              style: TextStyle(
                fontSize: w * 0.053,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Utilisez cette carte pour vos achats en ligne. Vous pouvez la recharger à tout moment.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: descColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.04),
            Text(
              "Solde du portefeuille : \$${_balance.toStringAsFixed(2)}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Montant (minimum 10 euros)',
                prefixText: '€',
              ),
              onChanged: (value) {
                _amount = double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 8.0),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              height: h * 0.07,
              child: CustomBtn(
                text: "Générer ma carte",
                onPressed: _generateCard,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _generatedCards.length,
                itemBuilder: (context, index) {
                  Map<String, String> card = _generatedCards[index];
                  String formattedCardNumber = card['cardNumber']!.replaceAllMapped(
                      RegExp(r".{4}"), (match) => "${match.group(0)} ");
                  return CreditCardWidget(
                    cardNumber: formattedCardNumber,
                    expiryDate: card['expiryDate']!,
                    cardHolderName: 'GNAHORE CHRISTELLE',
                    cvvCode: card['cvv']!,
                    showBackView: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    cardBgColor: Colors.blue,
                    isHolderNameVisible: true,
                    isChipVisible: true,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange: (brand) {},
                    obscureCardNumber: false,
                    obscureCardCvv: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}