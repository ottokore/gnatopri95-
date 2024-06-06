import 'package:dassi/Widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:dassi/admin/dashboard/admin_dashboard.dart';
import 'package:dassi/utils/utils.dart';

class EmailRegister extends StatefulWidget {
  const EmailRegister({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailRegisterState createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          TextFormField(
            cursorColor: primaryColor,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                isEmailValid = false;
                return 'Veuillez entrer une adresse e-mail';
              }
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if (!emailValid) {
                isEmailValid = false;
                return 'Veuillez entrer une adresse e-mail valide';
              }
              isEmailValid = true;
              return null;
            },
            style: TextStyle(
              color: primaryColor,
              fontSize: w*0.055,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: "Adresse e-mail",
              hintStyle: TextStyle(
                color: const Color.fromARGB(80, 0, 0, 0),
                fontSize: w*0.05,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: isEmailValid ? Colors.green : Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: isEmailValid ? Colors.green : primaryColor),
              ),
              prefixIcon: const Icon(Icons.email, color: Colors.black26, size: 22,),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            cursorColor: primaryColor,
            controller: passwordController,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                isPasswordValid = false;
                return 'Veuillez entrer un mot de passe';
              }
              isPasswordValid = true;
              return null;
            },
            style: TextStyle(
              color: primaryColor,
              fontSize: w * 0.055,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: "Mot de passe",
              hintStyle: TextStyle(
                color: const Color.fromARGB(80, 0, 0, 0),
                fontSize: w * 0.05,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: isPasswordValid ? Colors.green : Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: isPasswordValid ? Colors.green : primaryColor),
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.black26, size: 22,),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black26, size: 19,),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            cursorColor: primaryColor,
            controller: confirmPasswordController,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez confirmer le mot de passe';
              }
              if (value != passwordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
            style: TextStyle(
              color: primaryColor,
              fontSize: w * 0.055,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: "Confirmer",
              hintStyle: TextStyle(
                color: const Color.fromARGB(80, 0, 0, 0),
                fontSize: w * 0.05,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: primaryColor),
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.black26, size: 22,),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black26, size: 19,),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: h * 0.07,
            child: CustomBtn(
              text: "Admin Register",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Rediriger vers admin_dashboard.dart
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminDashboard()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Container(
                        padding: const EdgeInsets.all(16),
                        height: h * 0.15,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 221, 27, 13),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(passwordController.text.length < 8 ? 'Le mot de passe doit être de\n8 caractères minimum' : (!passwordController.text.contains(RegExp(r'[!@#\$&*~]'))) ? 'Le mot de passe doit contenir\nun caractère spécial' : (!passwordController.text.contains(RegExp(r'[A-Z]'))) ? 'Le mot de passe doit contenir\nau moins une majuscule' : 'Veuillez corriger les erreurs dans le formulaire', style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}