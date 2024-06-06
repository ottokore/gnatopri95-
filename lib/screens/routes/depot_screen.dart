import 'package:dassi/screens/routes/topup/credit_card_topup.dart';
import 'package:dassi/screens/routes/topup/mobile_topup.dart';
import 'package:dassi/screens/routes/topup/moov_topup.dart';
import 'package:dassi/screens/routes/topup/mtn_topup.dart';
import 'package:dassi/screens/routes/topup/paypal_topup.dart';
import 'package:dassi/screens/routes/topup/stripe_topup.dart';
import 'package:dassi/screens/routes/topup/wave_topup.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:dassi/screens/routes/topup/orange_money_topup.dart';

class DepotScreen extends StatelessWidget {
  const DepotScreen({super.key});

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

      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Je recharge mon eWallet',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Choisissez votre methode de paiement pour recharger votre eWallet.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: descColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
  onTap: () async {
    double? amount = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _amountController = TextEditingController();
        return AlertDialog(
          title: const Text('Saisir le montant'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: 'Entrez le montant',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                double? amount = double.tryParse(_amountController.text);
                Navigator.pop(context, amount);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (amount != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrangeMoneyTopup(),
          settings: RouteSettings(
            arguments: amount,
          ),
        ),
      );
    }
  },
  child: _buildImageButton('assets/images/orange_money.png', 'Orange Money'),
),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MtnTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/mtn_money.png', 'MTN Money'),
                          ),
                          
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MoovTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/moov_money.png', 'Moov Money'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WaveTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/wave.png', 'Wave'),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const PaypalTopup(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                                    var begin = const Offset(1.1, 0.0);
                                    var end = Offset.zero;
                                    var tween = Tween(begin: begin, end: end);
                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                      );
                            }
                          )               
                      );
                    },
                            child: _buildImageButton('assets/images/paypal.png', 'PayPal'),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const StripeTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/stripe.png', 'Stripe'),
                          ),

                          
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MobileTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/mobile_topup.png', 'Autre'),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CreditCardTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/credit_card.png', 'Carte de crédit'),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
      )


      
    );
  }

  Widget _buildImageButton(String imagePath, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 35, right: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            imagePath,
            width: 66,
            height: 66,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}