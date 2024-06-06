import 'package:dassi/auth/login.dart';
import 'package:dassi/auth/user_model.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _obscurePin = true;
  bool _obscureConfirmPin = true;
  final _confirmPinFocusNode = FocusNode();
  final List<String> _errorMessages = [];

  Future _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String? _validateName(String? value, {bool isFirstName = false}) {
    if (value == null || value.isEmpty) {
      _errorMessages.add('Le champ ${isFirstName ? 'Prénom(s)' : 'Nom'} est obligatoire');
      return '';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      _errorMessages.add('L\'adresse e-mail est obligatoire');
      return '';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      _errorMessages.add('Format e-mail invalide');
      return '';
    }
    return null;
  }

  String? _validateBirthday(String? value) {
    if (value == null || value.isEmpty) {
      _errorMessages.add('La date de naissance est obligatoire');
      return '';
    }
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      _errorMessages.add('Format de date invalide (jj/mm/aaaa)');
      return '';
    }
    final parts = value.split('/').map(int.parse).toList();
    final birthday = DateTime(parts[2], parts[1], parts[0]);
    final age = DateTime.now().difference(birthday).inDays ~/ 365;
    if (age < 18) {
      _errorMessages.add('Vous devez avoir au moins 18 ans');
      return '';
    }
    return null;
  }

  String? _validatePin(String? value) {
    if (value == null || value.isEmpty) {
      _errorMessages.add('Le code PIN est obligatoire');
      return '';
    }
    if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
      _errorMessages.add('Le code PIN doit contenir exactement 6 chiffres');
      return '';
    }
    if (RegExp(r'^(\d)\1{5}$').hasMatch(value)) {
      _errorMessages.add('Veuillez ne pas répéter le même chiffre 6 fois');
      return '';
    }
    if (value == '012345' || value == '123456' || value == '654321' || value == '987654') {
      _errorMessages.add('Veuillez éviter les séquences croissantes ou décroissantes');
      return '';
    }
    if (value == '000000' || value == '111111' || value == '222222' || 
        value == '333333' || value == '444444' || value == '555555' || 
        value == '666666' || value == '777777' || value == '888888' || 
        value == '999999') {
      _errorMessages.add('Veuillez saisir un code PIN plus sécurisé');
      return '';
    }
    return null;
  }

  String? _validateConfirmPin(String? value) {
    if (value == null || value.isEmpty) {
      _errorMessages.add('La confirmation du code PIN est obligatoire');
      return '';
    }
    if (value != _pinController.text) {
      _errorMessages.add('Les codes PIN ne correspondent pas');
      return '';
    }
    return null;
  }

  String _capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }

  String _capitalizeWithHyphens(String text) {
    if (text.isEmpty) return text;
    return text.split(RegExp(r'(-|\s)')).map((word) {
      return word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : word;
    }).join('-');
  }

  Future<String> uploadProfilePicture(File imageFile, String userId) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // message d'erreur
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Fond bleu fixe
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25 + kToolbarHeight,
              color: primaryColor,
            ),
            
            // Texte fixe au-dessus du fond bleu
            SafeArea(
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: const Column(
                  children: [
                    Text(
                      'Données personnelles',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Veuillez fournir vos informations personnelles.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(214, 255, 255, 255),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            // Contenu scrollable
            SingleChildScrollView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Prendre une photo'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _getImage(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Choisir dans la galerie'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _getImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: _image == null ? Colors.grey[200] : null,
                            backgroundImage: _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Photo', style: TextStyle(color: Colors.grey)),
                                      Icon(Icons.camera_alt, color: Colors.grey),
                                    ],
                                  )
                                : const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(Icons.camera_alt, color: Colors.white, shadows: [Shadow(blurRadius: 10, color: Colors.black54)]),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Votre Nom",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Nom',
                            prefixIcon: const Icon(Icons.person_outline),
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
                          validator: (value) => _validateName(value, isFirstName: false),
                          onChanged: (value) => _nameController.value = _nameController.value.copyWith(
                            text: _capitalize(value),
                            selection: TextSelection.collapsed(offset: _capitalize(value).length),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            hintText: "Prénom(s)",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Prénom(s)',
                            prefixIcon: const Icon(Icons.person_outline),
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
                          validator: (value) => _validateName(value, isFirstName: true),
                          onChanged: (value) {
                            value.split(RegExp(r'(-|\s)'));
                            final lastWordStart = value.lastIndexOf(RegExp(r'(-|\s)')) + 1;
                            final lastWord = value.substring(lastWordStart);
                            final capitalizedLastWord = _capitalizeWithHyphens(lastWord);
                            _firstNameController.value = _firstNameController.value.copyWith(
                              text: value.substring(0, lastWordStart) + capitalizedLastWord,
                              selection: TextSelection.collapsed(
                                offset: lastWordStart + capitalizedLastWord.length,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Adresse e-mail",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Adresse e-mail',
                            prefixIcon: const Icon(Icons.email_outlined),
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
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _birthdayController,
                          decoration: InputDecoration(
                            hintText: "Date de naissance",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Date de naissance',
                            prefixIcon: const Icon(Icons.calendar_month_outlined),
                            labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: secondaryColor),
                            ),
                            errorMaxLines: 2,
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: _validateBirthday,
                          onChanged: (value) {
                            if (value.length == 2 || value.length == 5) {
                              _birthdayController.text = '$value/';
                              _birthdayController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _birthdayController.text.length));
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _pinController,
                          decoration: InputDecoration(
                            hintText: "Code PIN",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w*0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Code PIN', 
                            prefixIcon: const Icon(Icons.lock_clock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePin ? Icons.visibility_off : Icons.visibility, color: lightColor),
                              onPressed: () {
                                setState(() {
                                  _obscurePin = !_obscurePin;});
                              },
                            ),
                            labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: secondaryColor),
                            ),
                            errorMaxLines: 2,
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: _obscurePin,
                          validator: _validatePin,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          onChanged: (value) {
                            if (value.length == 6) {
                              FocusScope.of(context).requestFocus(_confirmPinFocusNode);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _confirmPinController,
                          focusNode: _confirmPinFocusNode,
                          decoration: InputDecoration(
                            hintText: "Confirmer Code PIN",
                            hintStyle: TextStyle(
                              color: descColor,
                              fontSize: w*0.04,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Confirmer Code PIN', 
                            prefixIcon: const Icon(Icons.lock_clock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPin ? Icons.visibility_off : Icons.visibility, color: lightColor),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPin = !_obscureConfirmPin;
                                });
                              },
                            ),
                            labelStyle: const TextStyle(fontSize: 15, color: light2Color),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: secondaryColor),
                            ),
                            errorMaxLines: 2,
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: _obscureConfirmPin,
                          validator: _validateConfirmPin,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        const Text(
                          'Définissez votre code PIN à 6 chiffres.\n'
                          'Ce code vous permettra de vous connecter\n'
                          'à votre compte. Ne le partagez pas!',
                          style: TextStyle(fontSize: 14, color: lightColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              _errorMessages.clear();
                              if (_formKey.currentState!.validate()) {
                                if (_image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Veuillez sélectionner une photo de profil')),
                                  );
                                } else {
                                  try {
                                    // Créer un utilisateur dans Firebase Authentication
                                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password: _pinController.text.trim(),
                                    );

                                    // Stocker l'image dans Firebase Storage et obtenir l'URL
                                    String photoUrl = await uploadProfilePicture(_image!, userCredential.user!.uid);

                                    // Stocker les informations supplémentaires dans Firestore
                                    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                                      'name': _nameController.text.trim(),
                                      'firstName': _firstNameController.text.trim(),
                                      'email': _emailController.text.trim(),
                                      'birthday': _birthdayController.text.trim(),
                                      'pin': _pinController.text.trim(),
                                      'photoUrl': photoUrl,
                                    });

                                    // Initialiser le modèle utilisateur avec les données
                                    UserModel userModel = Provider.of<UserModel>(context, listen: false);
                                    userModel.setUser(
                                      name: _nameController.text.trim(),
                                      firstName: _firstNameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      birthday: _birthdayController.text.trim(),
                                      pin: _pinController.text.trim(),
                                      photoUrl: photoUrl,
                                    );

                                    // Naviguer vers la page d'accueil
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Une erreur s\'est produite : $e')),
                                    );
                                  }
                                }
                              } else {
                                // Au moins un champ n'est pas valide
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      padding: const EdgeInsets.all(16),
                                      height: h * 0.1 * (_errorMessages.length + 1), // Ajuste la hauteur en fonction du nombre de messages
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 221, 27, 13),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Veuillez corriger les erreurs suivantes :', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                          const SizedBox(height: 10),
                                          ..._errorMessages.map((msg) => Text(
                                            '• $msg',
                                            style: const TextStyle(color: Colors.white),
                                            textAlign: TextAlign.left,
                                          )),
                                        ],
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    duration: Duration(seconds: 4 + _errorMessages.length), // Durée plus longue pour plus de messages
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text('Valider', style: TextStyle(fontSize: w*0.042, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}