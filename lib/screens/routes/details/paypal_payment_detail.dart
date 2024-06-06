import 'package:dassi/screens/routes/depot_screen.dart';
import 'package:dassi/screens/routes/details/paypal_payment.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PaypalPaymentDetail extends StatefulWidget {
  const PaypalPaymentDetail({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaypalPaymentDetailState createState() => _PaypalPaymentDetailState();
}

class _PaypalPaymentDetailState extends State<PaypalPaymentDetail> {
  String? _selectedCurrency;
  final TextEditingController _amountController = TextEditingController();
  String? _amountError;

  @override
  void initState() {
    super.initState();
    _updateAmountText();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DepotScreen()),
            );
          },
        ),
        title: const Text(
          'Retour',
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: h * 0.07)),
              Text(
                "Rechargez via PayPal",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Choisissez votre devise avant de recharger votre eWallet",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: descColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.06),
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
                            _updateAmountText();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 200,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: primaryColor, width: 3.0)),
                ),
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: 'Montant',
                    prefixText: _selectedCurrency != null ? '${getCurrencySymbol(_selectedCurrency!)} ' : '',
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
              SizedBox(height: h * 0.06),
              GestureDetector(
  onTap: () {
    if (_selectedCurrency == null) {
      _showSnackbar(context, "Sélectionnez votre devise");
    } else if (_amountController.text.isEmpty) {
      setState(() {
        _amountError = "Veuillez entrer un montant";
      });
    } else {
      setState(() {
        _amountError = null;
      });
      final amount = double.parse(_amountController.text);
      final currency = _selectedCurrency!;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaypalPayment(
            amount: amount,
            currency: currency,
          ),
        ),
      );
    }
  },
  child: Container(
    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/paypal.png',
          height: 32.0,
        ),
        const SizedBox(
          width: 12.0,
        ),
        const Text(
          "Recharger via PayPal",
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  ),
)
            ],
          ),
        ),
      ),
    );
  }

  void _updateAmountText() {
    _amountController.value = TextEditingValue(
      text: _amountController.text.replaceAll(RegExp(r'^([^0-9]*)'), ''),
      selection: TextSelection.fromPosition(const TextPosition(offset: 0)),
    );
  }
}

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
        elevation:0,
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

String getCurrencySymbol(String currency) {
  switch (currency) {
    case 'CFA':
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
      return '';
  }
}

// Liste des devises
List<String> currencies = ['CFA', 'NGN', 'USD', 'EUR', 'GBP', 'CAD', 'YEN'];