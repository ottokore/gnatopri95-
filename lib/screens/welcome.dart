import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/auth/login.dart';
import 'package:dassi/auth/register.dart';
import 'package:dassi/screens/usage/privacy_policy.dart';
import 'package:dassi/screens/usage/term_of_use.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/welcome.png",
                      height: h * 0.3,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Bienvenue sur DassiPay !",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.04),
                    const Text(
                      "L'application qui vous permet de faire des paiements en toute simplicité.",
                      style: TextStyle(
                        color: descColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h * 0.03),

                    // Textes hyperlink avec redirection
                    Text.rich(
                      TextSpan(
                        text: "En vous inscrivant, vous acceptez nos ",
                        style: const TextStyle(
                          color: descColor,
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TermOfUse()),
                                );
                              },
                              child: const Text(
                                "Conditions générales d'utilisation",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(
                            text: " et notre ",
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicy()),
                                );
                              },
                              child: const Text(
                                "Politique de confidentialité",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(
                      height: h * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: w * 0.4,
                          height: h * 0.068,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 24, 104, 252),
                            ),
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.4,
                          height: h * 0.068,
                          child: CustomBtn(
                            text: "Connexion",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}