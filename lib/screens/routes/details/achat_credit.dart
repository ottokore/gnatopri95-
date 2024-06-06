import 'dart:convert';
import 'package:country_picker/country_picker.dart';
import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/screens/routes/details/achat_airtime.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';


void main() {
  runApp(const MaterialApp(
    title: 'Achat de crédit',
    home: AchatCredit(),
  ));
}

// Classe pour interagir avec l'API Reloadly
class ReloadlyAPI {
  static const baseUrl = 'https://topups.reloadly.com';
  final String clientId = 'x2bo3Yj0MGHWiJcHsYDvoy3qilgzzX7M';
  final String clientSecret = 'ybjZeLmXwv-V3nrZYmEL3rI8V0cXav-kyuAAQye8qHMBwv5dzMKc941fiNPX6r0';

  final _logger = Logger('ReloadlyAPI');

  Future<List<Operator>> getOperators(String countryCode) async {
    final url = Uri.parse('$baseUrl/operators/countries/$countryCode');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $clientId:$clientSecret'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final operators = responseData['operators'].map<Operator>((op) {
        return Operator.fromJson(op);
      }).toList();
      return operators;
    } else {
      throw Exception('Failed to load operators: ${response.body}');
    }
  }

  Future<void> topUp(int operatorId, String number, double amount) async {
    final url = Uri.parse('$baseUrl/topups');
    final body = json.encode({
      'operatorId': operatorId,
      'number': number,
      'amount': amount,
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $clientId:$clientSecret',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _logger.info('Top-up successful: ${responseData['status']}');
    } else {
      throw Exception('Failed to top-up: ${response.body}');
    }
  }
}

class Operator {
  final int id;
  final String name;

  Operator({required this.id, required this.name});

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['operatorId'],
      name: json['name'],
    );
  }
}

// Widget principal pour l'interface utilisateur
class AchatCredit extends StatefulWidget {
  const AchatCredit({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AchatCreditState createState() => _AchatCreditState();
}

class _AchatCreditState extends State<AchatCredit> {
  final _logger = Logger('_AchatCreditState');
  List<Operator> operators = [];
  Operator? selectedOperator;
  final numberController = TextEditingController();
  final amountController = TextEditingController();
  Country? selectedCountry;

  @override
void initState() {
  super.initState();
  selectedCountry = Country(
    phoneCode: "225",
    countryCode: "CI",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Côte d'Ivoire",
    example: "Côte d'Ivoire",
    displayName: "Côte d'Ivoire",
    displayNameNoCountryCode: "CI",
    e164Key: "",
  );
}

  Future<void> _loadOperators() async {
    if (selectedCountry == null) {
      return; // Aucun pays sélectionné, donc ne chargez pas les opérateurs
    }

    try {
      final reloadlyApi = ReloadlyAPI();
      final fetchedOperators =
          await reloadlyApi.getOperators(selectedCountry!.countryCode);
      setState(() {
        operators = fetchedOperators;
      });
    } catch (e) {
      // Gérer l'erreur de manière appropriée (par exemple, afficher un message d'erreur à l'utilisateur)
      _logger.severe("Failed to load operators: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AchatAirtime()),
            );
          },
        ),
        title: const Text('Airtime', style: TextStyle(color: primaryColor, fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: h * 0.04,
              ),
            ),
            Text(
              "Crédit de communication",
              style: TextStyle(
                fontSize: w * 0.053,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Achetez du crédit pour vous ou pour un proche quelque soit le pays.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: descColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.04),
            InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  countryListTheme: const CountryListThemeData(
                    bottomSheetHeight: 500,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  onSelect: (value) {
                    setState(() {
                      selectedCountry = value;
                      operators = []; // Réinitialiser la liste des opérateurs
                      selectedOperator = null; // Réinitialiser l'opérateur sélectionné
                    });
                    _loadOperators(); // Appeler cette méthode pour charger les opérateurs
                  },
                );
              },
              child: Text(
                "${selectedCountry?.flagEmoji} ${selectedCountry?.name}",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Operator>(
              value: selectedOperator,
              onChanged: (operator) {
                setState(() {
                  selectedOperator = operator;
                });
              },
              items: operators.map((operator) {
                return DropdownMenuItem<Operator>(
                  value: operator,
                  child: Text(operator.name),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Opérateur',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                labelText: "Numéro de téléphone",
                prefixText: selectedCountry?.phoneCode != null
                    ? "+${selectedCountry?.phoneCode} "
                    : "",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: "Montant à recharger",
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: h * 0.07,
              child: CustomBtn(
                text: "Recharger mon compte",
                onPressed: () async {
                  if (selectedOperator == null) {
                    // Afficher un message d'erreur si aucun opérateur n'a été sélectionné
                    _logger.severe('Veuillez sélectionner un opérateur');
                    return;
                  }

                  final number = numberController.text;
                  final amountString = amountController.text;
                  final amount = double.tryParse(amountString);

                  if (amount == null || amount <= 0) {
                    // Afficher un message d'erreur si le montant est invalide
                    _logger.severe('Veuillez entrer un montant valide');
                    return;
                  }

                  try {
                    final reloadlyApi = ReloadlyAPI();
                    await reloadlyApi.topUp(
                        selectedOperator!.id, number, amount);
                    // Afficher un message de succès ou effectuer d'autres actions nécessaires
                  } catch (e) {
                    // Gérer l'erreur de manière appropriée (par exemple, afficher un message d'erreur à l'utilisateur)
                    _logger.severe("Erreur lors de la recharge: $e");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
