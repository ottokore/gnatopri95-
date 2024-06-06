import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Classe pour interagir avec l'API Reloadly
class ReloadlyAPI {
  static const baseUrl = 'https://topups.reloadly.com';
  final String clientId = 'bWt2Xy0bzFtf2OgLOwPSuve7Ma1I3xpc';
  final String clientSecret = 'baUpGgQMHO-8xSO0Y0ZqCEusPbRty4-Vq0DxtoUGZO7UjYxJGvh5IOGNo31O8xe';

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
      throw Exception('Failed to load operators');
    }
  }

  Future<void> topUpData(int operatorId, String number, int bundle) async {
    final url = Uri.parse('$baseUrl/topups/data');
    final body = json.encode({
      'operatorId': operatorId,
      'number': number,
      'bundle': bundle,
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
      print('Data top-up successful: ${responseData['status']}');
    } else {
      throw Exception('Failed to top-up data: ${response.body}');
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

class AchatData extends StatefulWidget {
  const AchatData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AchatDataState createState() => _AchatDataState();
}

class _AchatDataState extends State<AchatData> {
    List<Operator> operators = [];
    Operator? selectedOperator;
    final numberController = TextEditingController();
    final bundleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadOperators();
  }

    Future<void> _loadOperators() async {
    try {
      final reloadlyApi = ReloadlyAPI();
      final fetchedOperators = await reloadlyApi.getOperators('FR');
      setState(() {
        operators = fetchedOperators;
      });
    } catch (e) {
      print('Failed to load operators: $e');
    }
  }

    Future<void> _topUpData() async {
    if (selectedOperator == null || numberController.text.isEmpty || bundleController.text.isEmpty) {
      return;
    }

      try {
      // Afficher un indicateur de chargement
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final reloadlyApi = ReloadlyAPI();
      await reloadlyApi.topUpData(selectedOperator!.id, numberController.text, int.parse(bundleController.text));

      // Fermer l'indicateur de chargement
      Navigator.of(context).pop();

      // Afficher une confirmation de transaction réussie
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Achat de data réussi'),
            content: Text('Votre achat de data ${bundleController.text} a été effectué avec succès.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Fermer l'indicateur de chargement
      Navigator.of(context).pop();

      // Afficher un message d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text('Une erreur s\'est produite lors de l\'achat de data: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reloadly Data Top-up'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Operator>(
              value: selectedOperator, 
              onChanged: (operator){
                setState(() {
                  selectedOperator = operator;
                });
              },
              items: operators.map((operator){
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
                decoration: const InputDecoration(
                labelText: 'Numéro de téléphone',
              ),
              ),
              const SizedBox(height: 16),
              TextField(
              controller: bundleController,
              decoration: const InputDecoration(
                labelText: 'ID du bundle data',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _topUpData,
              child: const Text('Acheter data'),
            ),
          ],
        ),
        ),
    );
  }
}