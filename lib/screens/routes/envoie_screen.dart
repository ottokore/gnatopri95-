import 'package:dassi/screens/routes/topup/mobile_topup.dart';
import 'package:dassi/screens/routes/send/orange_money_send.dart';
import 'package:dassi/screens/routes/send/mtn_money_send.dart';
import 'package:dassi/screens/routes/send/moov_money_send.dart';
import 'package:dassi/screens/routes/send/wave_send.dart';
import 'package:dassi/screens/routes/send/paypal_send.dart';
import 'package:dassi/screens/routes/send/stripe_send.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class EnvoieScreen extends StatelessWidget {
  const EnvoieScreen({super.key});

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
                    "J'envoie de l'argent",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Choisissez votre methode de paiement pour envoyer de l'argent.",
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OrangeMoneySend()),
                              );
                            },
                            child: _buildImageButton('assets/images/dassi_wallet_send.png', 'Dassi'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OrangeMoneySend()),
                              );
                            },
                            child: _buildImageButton('assets/images/orange_money.png', 'Orange Money'),
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
                                MaterialPageRoute(builder: (context) => const MtnMoneySend()),
                              );
                            },
                            child: _buildImageButton('assets/images/mtn_money.png', 'MTN Money'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MoovMoneySend()),
                              );
                            },
                            child: _buildImageButton('assets/images/moov_money.png', 'Moov Money'),
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
                                MaterialPageRoute(builder: (context) => const WaveSend()),
                              );
                            },
                            child: _buildImageButton('assets/images/wave.png', 'Wave'),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PaypalSend()),
                              );
                            },
                            child: _buildImageButton('assets/images/paypal.png', 'PayPal'),
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
                                MaterialPageRoute(builder: (context) => const StripeSend()),
                              );
                            },
                            child: _buildImageButton('assets/images/stripe.png', 'Stripe'),
                          ),
                          
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MobileTopup()),
                              );
                            },
                            child: _buildImageButton('assets/images/mobile_topup.png', 'Autre'),
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