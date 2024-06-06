import 'dart:async';
import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCreate extends StatefulWidget {
  const QrCodeCreate({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QrCodeCreateState createState() => _QrCodeCreateState();
}

class _QrCodeCreateState extends State<QrCodeCreate> {
  int _secondsRemaining = 300;
  bool _isCountdownFinished = false;
  Timer? _timer;
  String? _selectedCurrency;
  final TextEditingController _amountController = TextEditingController();
  String? _amountError;
  String _qrData = '';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _amountController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isCountdownFinished = true;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int secondsRemaining) {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 80,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 221, 27, 13),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void _generateQrCode() {
    final amount = _amountController.text.isNotEmpty ? _amountController.text : '0';
    final currency = _selectedCurrency ?? 'XOF';
    const name = 'Christelle Gnahoré';

    _qrData = 'Montant: $amount $currency, Nom: $name';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.001),
            ),
            Text(
              "Retrait par code QR",
              style: TextStyle(
                fontSize: w * 0.053,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: currencies.length,
                itemBuilder: (BuildContext context, int index) {
                  final currency = currencies[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CurrencyButton(
                      currency: currency,
                      selected: _selectedCurrency == currency,
                      onPressed: () {
                        setState(() {
                          _selectedCurrency = currency;
                          _amountController.text = getCurrencySymbol(currency) ?? '';
                          _amountError = null;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              width: 200,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: primaryColor, width: 3.0)),
              ),
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  hintText: 'Montant',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  errorText: _amountError,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: h * 0.07,
              child: CustomBtn(
                text: _isCountdownFinished ? "Générer un nouveau code QR" : "Générer le code QR",
                onPressed: () {
                  if (_selectedCurrency == null) {
                    _showSnackbar(context, "Sélectionnez votre devise");
                  } else {
                    _generateQrCode();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            _qrData.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: QrImageView(
                  data: _qrData,
                  version: QrVersions.auto, 
                  size: 210.0,
                  // ignore: deprecated_member_use
                  foregroundColor: const Color.fromARGB(255, 40, 63, 163),
                ),
              )
            : const SizedBox.shrink(),
            const SizedBox(height: 12),
            const Text(
              "Ce code QR ne sera plus valable dans.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: descColor,
              ),
              textAlign: TextAlign.center,
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _isCountdownFinished ? Colors.red : secondaryColor,
              ),
              child: _isCountdownFinished
                  ? const Text(
                      "Le code QR n'est plus valable",
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      _formatTime(_secondsRemaining),
                      textAlign: TextAlign.center,
                    ),
            ),
            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }
}

// Code pour les autres widgets...

class CurrencyButton extends StatelessWidget {
  final String currency;
  final bool selected;
  final VoidCallback onPressed;

  const CurrencyButton({
    super.key,
    required this.currency,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? primaryColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: selected ? primaryColor : Colors.grey.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        currency,
        style: TextStyle(
          color: selected ? Colors.white : primaryColor,
          fontSize: 15,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

String? getCurrencySymbol(String currency) {
  switch (currency) {
    case 'XOF':
      return 'FCFA'; // Pas de symbole pour le CFA
    case 'NGN':
      return '₦ ';
    case 'USD':
      return '\$ ';
    case 'EUR':
      return '€ ';
    case 'GBP':
      return '£ ';
    case 'CAD':
      return '\$ ';
    case 'YEN':
      return '¥ ';
    default:
      return null;
  }
}

// Liste des devises
List<String> currencies = ['XOF', 'NGN', 'USD', 'EUR', 'GBP', 'CAD', 'YEN'];