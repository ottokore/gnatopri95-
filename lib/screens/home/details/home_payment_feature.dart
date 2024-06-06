import 'package:dassi/screens/home/details/feature/epargne/onboard_saving.dart';
import 'package:dassi/screens/home/details/feature/suivi.dart';
import 'package:dassi/screens/routes/banque_screen.dart';
import 'package:dassi/screens/routes/facture_screen.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePaymentFeature extends StatefulWidget {
  const HomePaymentFeature({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePaymentFeatureState createState() => _HomePaymentFeatureState();
}

class _HomePaymentFeatureState extends State<HomePaymentFeature> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    //double w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: h*0.09,
                  height: h*0.09,
                  decoration: const BoxDecoration(
                    color: Color(0xffecedf2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/epargne.png', height: 33, color: descColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => OnboardSaving(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            var begin = const Offset(0.0, 1.0);
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
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Epargne', style: TextStyle(color: descColor, fontSize: 13)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: h*0.09,
                  height: h*0.09,
                  decoration: const BoxDecoration(
                    color: Color(0xffecedf2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/facture.png', height: 33, color: descColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FactureScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Facture', style: TextStyle(color: descColor, fontSize: 13)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: h*0.09,
                  height: h*0.09,
                  decoration: const BoxDecoration(
                    color: Color(0xffecedf2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/analytics.png', height: 33, color: descColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const SuiviTransactions(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            var begin = const Offset(0.0, 1.0);
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
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Suivi',style: TextStyle(color: descColor, fontSize: 13)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: h*0.09,
                  height: h*0.09,
                  decoration: const BoxDecoration(
                    color: Color(0xffecedf2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/images/banque.png', height: 33, color: descColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BanqueScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Banque', style: TextStyle(color: descColor, fontSize: 13)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}