import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dassi/widgets/francophone_african_countries.dart';
import 'dart:math';

class BanqueScreen extends StatefulWidget {
  const BanqueScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BanqueScreenState createState() => _BanqueScreenState();
}

class _BanqueScreenState extends State<BanqueScreen> {

  Map<String, List<String>> _banksByCountry = {};
  String? _selectedCountry;
  final String _expiryDate = '';
  List<String> _banks = [];
  String? _selectedCardBrand;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _loadBanksData();
    _generateCardDetails();
  }

  void _generateCardDetails() {
    // ...
    _expirationDateController.text = _expiryDate;
  }

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    // Le formulaire est valide, vous pouvez effectuer les actions nécessaires ici
  }
}

  Future<void> _loadBanksData() async {
    final jsonString = await rootBundle.loadString('assets/banks_data.json');
    final jsonData = jsonDecode(jsonString);

    // Convertir les valeurs de la Map en List<String>
    final Map<String, dynamic> jsonDataMap = jsonData.cast<String, dynamic>();
    final Map<String, List<String>> banksByCountry = {};

    jsonDataMap.forEach((key, value) {
      banksByCountry[key] = List<String>.from(value.cast<dynamic>());
    });

    setState(() {
      _banksByCountry = banksByCountry;
    });
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColor,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Image.asset(
                'assets/images/dassi_logo.png',
                height: 26,
              ),
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: h * 0.04,
                ),
              ),
              Text(
                "Connectez votre banque",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Consultez en temps réel votre solde en ajoutant votre carte de crédit.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: descColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.04),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey, // Couleur de la bordure
                    width: 1.0, // Largeur de la bordure
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: "Type de carte",
                    border: InputBorder.none, // Supprimer la bordure initiale
                  ),
                  value: _selectedCardBrand,
                  onChanged: (value) {
                    setState(() {
                      _selectedCardBrand = value;
                      _selectedCountry = null;
                      _banks.clear();
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'visa',
                      child: Text('Visa'),
                    ),
                    DropdownMenuItem(
                      value: 'mastercard',
                      child: Text('Mastercard'),
                    ),
                    
                  ],
                ),
              ),


              const SizedBox(height: 16.0),
            _selectedCardBrand == null
              ? Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey, // Couleur de la bordure
                        width: 1.0, // Largeur de la bordure
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: "Votre pays",
                        border: InputBorder.none, // Supprimer la bordure initiale
                      ),
                      items: const [],
                      onChanged: null,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: descColor, // Couleur de la bordure
                      width: 1.0, // Largeur de la bordure
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Supprimer la bordure initiale
                    ),
                    value: _selectedCountry,
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                        _banks = _banksByCountry[value] ?? [];
                      });
                    },
                    items: francophoneAfricanCountries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey, // Couleur de la bordure
                    width: 1.0, // Largeur de la bordure
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: "Nom de la banque",
                    border: InputBorder.none, // Supprimer la bordure initiale
                  ),
                  value: _banks.isNotEmpty ? _banks.first : null,
                  onChanged: _banks.isNotEmpty
                      ? (value) {
                          setState(() {
                            // Mettez ici la logique pour gérer la sélection de la banque
                          });
                        }
                      : null,
                  items: _banks
                      .map(
                        (bank) => DropdownMenuItem(
                          value: bank,
                          child: Text(bank),
                        ),
                      )
                      .toList(),
                ),
              ),

              SizedBox(height: h * 0.04),
              Text(
                "Informations de votre carte",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: h * 0.022),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: w*0.035,
                        fontWeight: FontWeight.w500,
                        fontFamily: "cardFont"
                      ),
                      decoration: InputDecoration(
                        labelText: "Nom sur la carte",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: descColor)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: descColor)
                        ),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez saisir votre nom";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      cursorColor: primaryColor,
                      controller: _cardNumberController,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: w*0.035,
                        fontWeight: FontWeight.w500,
                        fontFamily: "cardFont"
                      ),
                      decoration: InputDecoration(
                        labelText: "Numéro de carte",
                        prefixIcon: const Icon(Icons.credit_card_outlined),
                        
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: descColor)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: descColor)
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberFormatter(),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez saisir le numéro de votre carte";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _expirationDateController,
                            cursorColor: primaryColor,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                              fontFamily: "cardFont"
                            ),
                            decoration: InputDecoration(
                              labelText: "MM/AA",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: descColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: descColor)
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.red)
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                              _ExpirationDateFormatter(),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez saisir la date d'expiration";
                              } else if (!isValidExpirationDate(value)) {
                                return "Date d'expiration invalide";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            cursorColor: primaryColor,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: w*0.035,
                              fontWeight: FontWeight.w500,
                              fontFamily: "cardFont"
                            ),
                            decoration: InputDecoration(
                              labelText: "CVV",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: descColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: descColor)
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "CVV obligatoire";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                    width: double.infinity,
                    height: h*0.07,
                    child: CustomBtn(
                      text: "Connecter ma banque",
                      onPressed: _submitForm,
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidExpirationDate(String value) {
  if (value.isEmpty) {
    return false;
  }

  final currentYear = DateTime.now().year;
  final currentMonth = DateTime.now().month;

  final year = int.tryParse(value.substring(3, 5));
  final month = int.tryParse(value.substring(0, 2));

  if (year == null || month == null || month < 1 || month > 12) {
    return false;
  }

  final expiryYear = 2000 + year;
  final expiryDate = DateTime(expiryYear, month);
  final currentDate = DateTime(currentYear, currentMonth);

  return expiryDate.isAfter(currentDate);
}
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i += 4) {
      buffer.write(newText.substring(i, min(i + 4, newText.length)));
      if (i + 4 < newText.length) {
        buffer.write(' ');
      }
    }
    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class _ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final currentMonth = DateTime.now().month;

    if (newText.length > 2 && !newText.contains('/')) {
      final month = int.tryParse(newText.substring(0, 2));
      if (month != null && month > 0 && month <= 12) {
        return TextEditingValue(
          text: '${newText.substring(0, 2)}/${newText.substring(2)}',
          selection: TextSelection.collapsed(
            offset: newText.length + 1,
          ),
        );
      }
    }

    if (newText.length == 5) {
      final year = int.tryParse(newText.substring(3, 5));
      final month = int.tryParse(newText.substring(0, 2));

      if (year != null && month != null && month > 0 && month <= 12) {
        final expiryYear = 2000 + year;
        final expiryDate = DateTime(expiryYear, month);
        final currentDate = DateTime(DateTime.now().year, currentMonth);

        if (expiryDate.isAfter(currentDate)) {
          return newValue;
        }
      }
      return oldValue;
    }

    return newValue;
  }
}