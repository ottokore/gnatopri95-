import 'package:dassi/auth/forgot_pin.dart';
import 'package:dassi/auth/user_model.dart';
import 'package:dassi/screens/home/user_dashboard.dart';
import 'package:dassi/screens/welcome.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _enteredPin = '';
  bool _isLoading = false;
  int _attempts = 0;
  bool _isLocked = false;
  DateTime? _lockoutEndTime;

  void _handlePinInput(String digit) {
    if (_isLocked) {
      _showErrorMessage('Compte temporairement bloqué. Réessayez plus tard.');
      return;
    }

    setState(() {
      if (_enteredPin.length < 6) {
        _enteredPin += digit;
        if (_enteredPin.length == 6) {
          _authenticateUser();
        }
      }
    });
  }

  void _handleDeletePin() {
    setState(() {
      if (_enteredPin.isNotEmpty) {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      }
    });
  }

  void _authenticateUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('pin', isEqualTo: _enteredPin)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        final userName = userData['firstName'] as String? ?? 'Utilisateur';
        final userId = userData['id'] as String?;

        // Mise à jour de l'état global de l'utilisateur
        final userModel = Provider.of<UserModel>(context, listen: false);
        userModel.setUser(
          id: userId ?? '',
          firstName: userName,
          pin: _enteredPin,
          // ... autres champs d'utilisateur
        );
        
        // Réinitialiser le compteur de tentatives
        _attempts = 0;
        
        // Naviguer vers la page d'accueil
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const UserDashboard()),
        );
        
        // Afficher un message de bienvenue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bienvenue, $userName !', style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        _handleFailedAttempt();
      }
    } catch (e) {
      print('Erreur: $e');
      if (e is FirebaseException) {
        if (e.code == 'network-request-failed') {
          _showErrorMessage('Vérifiez votre connexion internet');
        } else if (e.code == 'permission-denied') {
          _showErrorMessage('Accès refusé. Contactez le support.');
        } else {
          _showErrorMessage('Une erreur s\'est produite');
        }
      } else {
        _showErrorMessage('Une erreur s\'est produite');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleFailedAttempt() {
    _attempts++;
    if (_attempts >= 3) {
      _isLocked = true;
      _lockoutEndTime = DateTime.now().add(const Duration(minutes: 15));
      Future.delayed(const Duration(minutes: 15), () {
        setState(() {
          _isLocked = false;
          _attempts = 0;
        });
      });
      _showErrorMessage('Compte bloqué pendant 15 minutes après 3 tentatives infructueuses.');
    } else {
      _showErrorMessage('Code PIN incorrect. Tentative $_attempts/3');
    }
    setState(() {
      _enteredPin = '';
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
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
          onPressed: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => const WelcomeScreen())
            );
          }, 
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
        ),
        title: const Text('Code PIN', style: TextStyle(color: primaryColor, fontSize: 18)),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
                  child: Text(
                    _isLocked 
                    ? 'Compte bloqué jusqu\'à ${_lockoutEndTime?.hour}:${_lockoutEndTime?.minute.toString().padLeft(2, '0')}' 
                    : 'Veuillez saisir votre code PIN à 6 chiffres.',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height:  h * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => Container(
                      margin: const EdgeInsets.all(8.0),
                      width: w * 0.045,
                      height: h * 0.045,
                      decoration: BoxDecoration(
                        color: _enteredPin.length > index
                            ? primaryColor
                            : Colors.black26,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.06),
                SizedBox(
                  width: w * 0.8,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNumberButton('1'),
                          _buildNumberButton('2'),
                          _buildNumberButton('3'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNumberButton('4'),
                          _buildNumberButton('5'),
                          _buildNumberButton('6'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNumberButton('7'),
                          _buildNumberButton('8'),
                          _buildNumberButton('9'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPin()),
                              );
                            },
                            child: const Text(
                              "Oublié ?",
                              style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _buildNumberButton('0'),
                          IconButton(
                            onPressed: _handleDeletePin,
                            icon: const Icon(Icons.backspace),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String digit) {
    return ElevatedButton(
      onPressed: () => _handlePinInput(digit),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16.0),
      ),
      child: Text(
        digit,
        style: const TextStyle(fontSize: 26.0, color: primaryColor),
      ),
    );
  }
}