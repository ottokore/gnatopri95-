import 'package:dassi/screens/routes/bottom_navigation/create_payment.dart';
import 'package:dassi/screens/routes/bottom_navigation/qr_code_create.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dassi/utils/utils.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _iconList = [
    Icons.home_outlined,
    Icons.credit_card_outlined,
    Icons.contact_phone_outlined,
    Icons.notifications_none_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBottomNavigationBar(
          height: 70,
          iconSize: 28,
          icons: _iconList,
          activeIndex: _currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          activeColor: secondaryColor,
          inactiveColor: Colors.black38,
          backgroundColor: Colors.white,
          leftCornerRadius: 40,
          rightCornerRadius: 40,
          shadow: BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(3, 0),
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        Positioned(
          bottom: 5,
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: FloatingActionButton(
            onPressed: () {
              showQRCodeDialog(context);
            },
            backgroundColor: secondaryColor,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.qr_code, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void showQRCodeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "QR Code",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Ajout de la marge ici
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Générer un code QR",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Générer un code QR pour faire ou recevoir un paiement.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Logique pour recevoir un paiement
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreatePayment(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                            icon: const Icon(Icons.call_received, color: secondaryColor, size: 18,),
                            label: const Text(
                              "Je reçois",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Logique pour faire un paiement
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QrCodeCreate(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                            icon: const Icon(Icons.call_made, color: secondaryColor, size: 18,),
                            label: const Text(
                              "J'envoie",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}