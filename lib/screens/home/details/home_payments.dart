import 'package:dassi/screens/home/details/virtual_card.dart';
import 'package:dassi/screens/routes/depot_screen.dart';
import 'package:dassi/screens/routes/details/achat_airtime.dart';
import 'package:dassi/screens/routes/envoie_screen.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePayments extends StatefulWidget {
  const HomePayments({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePaymentsState createState() => _HomePaymentsState();
}

class _HomePaymentsState extends State<HomePayments> {
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
                    icon: Image.asset('assets/images/dassi_wallet.png', height: 43,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const DepotScreen(),
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
                const Text('Dépôt', style: TextStyle(color: descColor, fontSize: 13)),
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
                    icon: Image.asset('assets/images/envoi.png', height: 38, color: primaryColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const EnvoieScreen(),
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
                const Text('Envoi', style: TextStyle(color: descColor, fontSize: 13)),
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
                    icon: Image.asset('assets/images/carte.png', height: 38, color: primaryColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const VirtualCard(),
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
                const Text('Mes cartes', style: TextStyle(color: descColor, fontSize: 13)),
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
                    icon: Image.asset('assets/images/airtime.png', height: 33, color: primaryColor,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const AchatAirtime(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            //var begin = const Offset(1.1, 0.0);
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
                const Text('Airtime', style: TextStyle(color: descColor, fontSize: 13)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}