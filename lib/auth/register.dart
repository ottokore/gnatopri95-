import 'package:dassi/auth/admin_auth/admin_auth.dart';
import 'package:dassi/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Importez le package provider
import 'package:dassi/auth/phone_verification.dart';
import 'package:dassi/screens/welcome.dart';
import 'package:dassi/widgets/custom_btn.dart';
import 'package:dassi/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

import 'package:dassi/auth/auth_provider.dart'; // Importez votre AuthProvider

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "225",
    countryCode: "CI",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Côte d'Ivoire",
    example: "Côte d'Ivoire",
    displayName: "Côte d'Ivoire",
    displayNameNoCountryCode: "CI",
    e164Key: ""
  );

  List<TextInputFormatter>? _inputFormatters;
  int _tapCount = 0;
  Timer? _tapTimer;
  final Duration _tapInterval = const Duration(seconds: 1);

  @override
  void dispose() {
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length)
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
        title: const Text('Retour', style: TextStyle(color: primaryColor, fontSize: 18),),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _tapCount++;
            _tapTimer?.cancel();
            _tapTimer = Timer(_tapInterval, () {
              _tapCount = 0;
            });

            if (_tapCount == 7) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminAuth()),
              );
            }
          });
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Column(
                  children: [
                    Container(
                      width: h*0.2,
                      height: h*0.2,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(72, 168, 175, 216),
                      ),
                      child: Image.asset("assets/register.png"),
                    ),

                    const SizedBox(height: 20),
                    Text("Identification",
                      style: TextStyle(
                        fontSize: w*0.07,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: h*0.020),
                    Text("Entrer votre numéro de téléphone. Nous vous enverrons un code de confirmation.",
                      style: TextStyle(
                        fontSize:  w*0.045,
                        color: descColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h*0.045),
                    TextField(
                      cursorColor: primaryColor,
                      controller: phoneController,
                      maxLength: 10,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: w*0.055,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                          if (value.isNotEmpty) {
                            _inputFormatters = [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ];
                          } else {
                            _inputFormatters = null;
                          }
                        });
                      },
                      keyboardType: TextInputType.phone,
                      inputFormatters: _inputFormatters,
                      decoration: InputDecoration(
                        hintText: "N° de téléphone",
                        hintStyle: TextStyle(
                          color: descColor,
                          fontSize: w*0.05,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                            left: 8,
                            right: 8
                          ),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                }
                              );
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: w*0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length == 10 ? Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 15,
                          ),
                        ) : null,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      width: double.infinity,
                      height:h*0.07,
                        child: CustomBtn(
                        text: "Suivant",
                        onPressed: () {
                        if (phoneController.text.length == 10) {
                          final phoneNumber = "+${selectedCountry.phoneCode}${phoneController.text}";

                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          authProvider.verifyPhoneNumber(
                            phoneNumber,
                            selectedCountry.phoneCode,
                            selectedCountry.countryCode,
                            (verificationId) {
                              // Mettre à jour le UserModel avec les informations de téléphone avant de passer à l'étape suivante
                              Provider.of<UserModel>(context, listen: false).setPhoneInfo(
                                phoneNumber: phoneNumber,
                                phoneCode: selectedCountry.phoneCode,
                                countryCode: selectedCountry.countryCode,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneVerification(
                                    phoneNumber: phoneNumber,
                                    verificationId: verificationId,
                                  ),
                                ),
                              );
                            },
                            context,
                          );
                        }
                      }
                      )
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
