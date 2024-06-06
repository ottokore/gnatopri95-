import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('fr');
    const balance = 34567980.49;
    const commissionReceived = 8346090.12;
    const expenses = 987670.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/design.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenue, Gnahoré',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Votre solde',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: '${numberFormat.format(balance)},00 '),
                      const TextSpan(
                        text: 'XOF',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reçu',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(text: '${numberFormat.format(commissionReceived)},00 '),
                              const TextSpan(
                                text: 'XOF',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dépenses',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(text: '${numberFormat.format(expenses)},00 '),
                              const TextSpan(
                                text: 'XOF',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const ElevatedButton(
            onPressed: null,
            child: Text('Retrait'),
          ),
        ],
      ),
    );
  }
}