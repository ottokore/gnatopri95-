import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VirtualCard extends StatefulWidget {
  const VirtualCard({super.key});

  @override
  _VirtualCardState createState() => _VirtualCardState();
}

class _VirtualCardState extends State<VirtualCard> {
  final String applicationToken = 'f3dc2422-6d50-4af6-8129-2d02d801f31e';
  final String adminAccessToken = 'd75753d7-ca32-4f96-a21a-179ffd8338e6';
  final String baseUrl = 'https://sandbox-api.marqeta.com/v3/';

  Future<Map<String, dynamic>> createVirtualCard() async {
    final url = Uri.parse('$baseUrl/cards?token=$applicationToken');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$applicationToken:$adminAccessToken')),
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "card_product_token": "Your_Card_Product_Token_Here",
      "user_token": "Your_User_Token_Here",
      "expedite": true
    });

    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create virtual card: ${response.body}');
    }
  }

  void _handleCreateCard() async {
    try {
      final cardDetails = await createVirtualCard();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Virtual Card Created'),
          content: Text('Card Token: ${cardDetails['token']}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<List<dynamic>> fetchCardProducts() async {
    final url = Uri.parse('$baseUrl/cardproducts?sort_by=-lastModifiedTime');
    final headers = {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$applicationToken:$adminAccessToken')),
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to fetch card products: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Virtual Card'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleCreateCard,
              child: Text('Créer une carte virtuelle'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardProductsPage(fetchCardProducts)),
                );
              },
              child: Text('View Card Products'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardProductsPage extends StatelessWidget {
  final Future<List<dynamic>> Function() fetchCardProducts;

  CardProductsPage(this.fetchCardProducts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Products'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchCardProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No card products found'));
          } else {
            final cardProducts = snapshot.data!;
            return ListView.builder(
              itemCount: cardProducts.length,
              itemBuilder: (context, index) {
                final cardProduct = cardProducts[index];
                return ListTile(
                  title: Text(cardProduct['name']),
                  subtitle: Text('Token: ${cardProduct['token']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
