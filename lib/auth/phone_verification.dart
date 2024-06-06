import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importez le package provider
import 'package:pinput/pinput.dart';
import 'dart:async';

import 'package:dassi/auth/auth_provider.dart'; // Importez votre AuthProvider
import 'user_info.dart'; // Importez votre UserInfo

class PhoneVerification extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const PhoneVerification({super.key, required this.phoneNumber, required this.verificationId});

  @override
  // ignore: library_private_types_in_public_api
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final _pinController = TextEditingController();
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    _pinController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.removeListener(_updateButtonState);
    _pinController.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void resendCode() {
    setState(() {
      _secondsRemaining = 60;
      startTimer();
    });
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _pinController.text.length == 6;
    });
  }

  Widget get timerWidget {
    if (_secondsRemaining > 0) {
      int minutes = _secondsRemaining ~/ 60;
      int seconds = _secondsRemaining % 60;
      return Text(
        '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}',
        style: const TextStyle(fontSize: 16),
      );
    } else {
      return const Text(
        'Temps écoulé, renvoyez le code',
        style: TextStyle(fontSize: 16, color: Colors.red),
      );
    }
  }

  void _verifyOTP() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final smsCode = _pinController.text;
    try {
      await authProvider.signInWithOTP(widget.verificationId, smsCode);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserInfo()), // Naviguez vers user_info.dart
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to verify OTP: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: h * 0.2,
                    height: h * 0.2,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(72, 168, 175, 216),
                    ),
                    child: Image.asset("assets/login.png"),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Confirmation",
                    style: TextStyle(
                      fontSize: w * 0.07,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Veuillez entrer le code à 6 chiffres envoyé au numéro",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: descColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  timerWidget,
                  const SizedBox(height: 30),
                  Pinput(
                    controller: _pinController,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 40,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _verifyOTP : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled ? primaryColor : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('Suivant', style: TextStyle(fontSize: w * 0.042, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Code non reçu ? ', style: TextStyle(fontSize: 15, color: primaryColor)),
                      TextButton(
                        onPressed: () {
                          resendCode();
                        },
                        child: const Text('Renvoyer', style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
