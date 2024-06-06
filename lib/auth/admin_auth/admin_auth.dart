import 'package:dassi/Widgets/custom_btn2.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';

class AdminAuth extends StatefulWidget {
  const AdminAuth({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminAuthState createState() => _AdminAuthState();
}

class _AdminAuthState extends State<AdminAuth> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Veuillez entrer une adresse e-mail';
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
    if (!emailValid) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Veuillez entrer un mot de passe';
    }
    bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!);
    if (!passwordValid) {
      return 'Le mot de passe doit contenir au moins 8 caractères, une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: secondaryColor,
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: const Color(0xFFF5F5F5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'Créer un compte Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 32.0),
                Container(
                  decoration: BoxDecoration(
                  
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Créer un compte'),
                          Tab(text: 'Se connecter'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: TabBarView(
                          controller: _tabController,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // Formulaire de création de compte
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: "Nom complet",
                                          hintStyle: TextStyle(
                                            color: descColor,
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          labelText: "Nom",
                                          labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.black12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: secondaryColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          hintText: "Adresse e-mail",
                                          hintStyle: TextStyle(
                                            color: descColor,
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          labelText: 'E-mail',
                                          labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.black12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: secondaryColor),
                                          ),
                                        ),
                                        validator: _validateEmail,
                                      ),
                                      const SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Mot de passe",
                                          hintStyle: TextStyle(
                                            color: descColor,
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          labelText: 'Mot de passe',
                                          labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.black12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: secondaryColor),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText ? Icons.visibility : Icons.visibility_off,
                                              size: 20.0,
                                              color: light2Color,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                        validator: _validatePassword,
                                      ),
                                      const SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Confirmer",
                                          hintStyle: TextStyle(
                                            color: descColor,
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          labelText: 'Confirmer le mot de passe',
                                          labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Colors.black12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: secondaryColor),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText ? Icons.visibility : Icons.visibility_off,
                                              size: 20.0,
                                              color: light2Color,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value != _passwordController.text) {
                                            return 'Les mots de passe ne correspondent pas';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16.0),

                                      SizedBox(
                                        width: double.infinity,
                                        height:h*0.07,
                                        child: CustomBtn2(text: "Créer mon compte",
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            // Logique de création de compte
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
                                                      Text(_passwordController.text.length < 8 ? 'Le mot de passe doit être de\n8 caractères minimum' : (!_passwordController.text.contains(RegExp(r'[!@#\$&*~]'))) ? 'Le mot de passe doit contenir\nun caractère spécial' : (!_passwordController.text.contains(RegExp(r'[A-Z]'))) ? 'Le mot de passe doit contenir\nau moins une majuscule' : 'Veuillez corriger les erreurs dans le formulaire', style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
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

                                      const SizedBox(height: 16.0),
                                      const Text(
                                        'Avez-vous déjà un compte?',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Logique pour changer de formulaire
                                          _tabController.animateTo(1);
                                        },
                                        child: const Text(
                                          'Connectez-vous',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Formulaire de connexion
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      key: const Key('email_field'),
                                      decoration: InputDecoration(
                                      hintText: "Adresse e-mail",
                                      hintStyle: TextStyle(
                                        color: descColor,
                                        fontSize: w*0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      labelText: 'E-mail',
                                      labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.black12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: secondaryColor),
                                      ),
                                    ),
                                    ),
                                    const SizedBox(height: 16.0 ),
                                    TextField(
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                      hintText: "Mot de passe",
                                      hintStyle: TextStyle(
                                        color: descColor,
                                        fontSize: w*0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      labelText: 'Mot de passe',
                                      labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.black12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: secondaryColor),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText ? Icons.visibility : Icons.visibility_off,
                                          size: 20.0,
                                          color: light2Color,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                      width: double.infinity,
                                      height:h*0.07,
                                      child: CustomBtn2(text: "Se connecter",
                                        onPressed: () {
                                          //
                                        }
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Text(
                                      'Pas encore de compte?',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Logique pour changer de formulaire
                                        _tabController.animateTo(0);
                                      },
                                      child: const Text(
                                        'Créer un compte',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}