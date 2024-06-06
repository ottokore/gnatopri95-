import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Changer la couleur de la barre de statut en blanc
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Couleur de la barre de statut
      statusBarIconBrightness: Brightness.light, // Couleur des icônes de la barre de statut (dark = noir)
    ));

    return GetBuilder<AmountWidgetController>(
      init: AmountWidgetController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mon solde',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(158, 255, 255, 255),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatWalletBalance(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                    child: DropdownButton<String>(
                      value: controller.selectedCurrency.value,
                      dropdownColor: secondaryColor,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: <String>['XOF', 'USD', 'EUR', 'GBP']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: controller.handleCurrencyChange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AmountWidgetController extends GetxController {
  double walletBalance = 95750.0; // Initial balance is 0.00 XOF
  final Rx<String> selectedCurrency = Rx<String>('XOF');

  final NumberFormat xofFormat = NumberFormat.currency(locale: 'fr_FR', symbol: 'F');
  final NumberFormat usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  final NumberFormat eurFormat = NumberFormat.currency(locale: 'fr_FR', symbol: '€');
  final NumberFormat gbpFormat = NumberFormat.currency(locale: 'en_GB', symbol: '£');

  final double xofToUsdRate = 0.0016; // Replace with the actual conversion rate
  final double xofToEurRate = 0.0015; // Replace with the actual conversion rate
  final double xofToGbpRate = 0.0013;

  void handleCurrencyChange(String? newValue) {
    selectedCurrency.value = newValue!;
    convertWalletBalance();
  }

  void convertWalletBalance() {
    if (selectedCurrency.value == 'XOF') {
      walletBalance = 95750.0; // Reset to the initial XOF balance of 0.00
    } else if (selectedCurrency.value == 'USD') {
      walletBalance = 95750.0 * xofToUsdRate;
    } else if (selectedCurrency.value == 'EUR') {
      walletBalance = 95750.0 * xofToEurRate;
    } else if (selectedCurrency.value == 'GBP') {
      walletBalance = 95750.0 * xofToGbpRate;
    }
    update(); // Notifier les widgets dépendants du changement d'état
  }

  String formatWalletBalance() {
    switch (selectedCurrency.value) {
      case 'XOF':
        return xofFormat.format(walletBalance);
      case 'USD':
        return usdFormat.format(walletBalance);
      case 'EUR':
        return eurFormat.format(walletBalance);
      case 'GBP':
        return gbpFormat.format(walletBalance);
      default:
        return walletBalance.toStringAsFixed(2);
    }
  }

  void updateWalletBalance(double amount) {
    walletBalance += amount;
    update(); // Notifier les widgets dépendants du changement d'état
  }
}