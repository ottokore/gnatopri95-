import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dassi/screens/routes/users.dart';
import 'package:dassi/screens/routes/envoie_screen.dart';
import 'package:country_picker/country_picker.dart';

class OrangeMoneySend extends StatefulWidget {
  const OrangeMoneySend({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrangeMoneySendState createState() => _OrangeMoneySendState();
}

class _OrangeMoneySendState extends State<OrangeMoneySend> {
  int _selectedMethod = -1;
  int _selectedAmount = -1;
  final TextEditingController _customAmountController = TextEditingController();
  int _selectedRecipient = -1;
  final List<int> _amounts = [5000, 10000, 20000, 50000, 100000, 150000];

  final TextEditingController _recipientPhoneController = TextEditingController();
  final TextEditingController _orangePhoneController = TextEditingController();
  final TextEditingController _destinationPhoneController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Retour',
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.053),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: h * 0.03)),
              Text(
                "Transaction via Orange Money",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Choisissez votre méthode de transaction",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: descColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.06),
              ...List.generate(
                transferMethods.length,
                (index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMethod = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedMethod == index ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _selectedMethod == index
                                  ? transferMethods[index].sendingImageUrlWhite
                                  : transferMethods[index].sendingImageUrl,
                              height: 45,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transferMethods[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: _selectedMethod == index ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  transferMethods[index].feesText,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _selectedMethod == index ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Image.asset(
                              _selectedMethod == index
                                  ? transferMethods[index].receivingImageUrlWhite
                                  : transferMethods[index].receivingImageUrl,
                              height: 45,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index < transferMethods.length - 1)
                      const SizedBox(height: 18),
                  ],
                ),
              ),
              SizedBox(height: h * 0.05),
              Text(
                "Montants prédéfinis",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: descColor,
                ),
              ),
              SizedBox(height: h * 0.03),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _amounts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAmount = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedAmount == index ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                        margin: const EdgeInsets.only(right: 8),
                        child: Center(
                          child: Text(
                            '${_amounts[index]} F',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _selectedAmount == index ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: h * 0.05),
              Text(
                "Montant personnalisé",
                style: TextStyle(
                  fontSize: w * 0.053,
                  fontWeight: FontWeight.bold,
                  color: descColor,
                ),
              ),
              SizedBox(height: h * 0.03),
              Container(
                width: 150.0,
                decoration: const BoxDecoration(
                  border:Border(bottom: BorderSide(color: primaryColor, width: 3.0)),
                ),
                child: TextField(
                  controller: _customAmountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'MONTANT',
                    hintStyle: TextStyle(fontSize: 16, color: descColor),
                    suffixText: 'FCFA ',
                    suffixStyle: TextStyle(fontSize: 16, color: descColor),
                  ),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: h * 0.03),
              if (_selectedMethod == 0) // Dassi vers Orange
                _buildRecipientPhoneField(),
              if (_selectedMethod == 1) // Orange vers MTN
                Column(
                  children: [
                    _buildOrangePhoneField(),
                    _buildDestinationPhoneField('Numéro MTN du destinataire'),
                  ],
                ),
              if (_selectedMethod == 2) // Orange vers Moov
                Column(
                  children: [
                    _buildOrangePhoneField(),
                    _buildDestinationPhoneField('Numéro Moov du destinataire'),
                  ],
                ),
              if (_selectedMethod == 3) // Orange vers Wave
                Column(
                  children: [
                    _buildOrangePhoneField(),
                    _buildDestinationPhoneField('Numéro Wave du destinataire'),
                  ],
                ),

              SizedBox(height: h * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Destinataire",
                    style: TextStyle(
                      fontSize: w * 0.053,
                      fontWeight: FontWeight.bold,
                      color: descColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Annuler
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)
                    ),
                    child: const Text('+ Ajouter',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.025),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index < users.length - 1 ? 16.0 : 0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedRecipient = index),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedRecipient == index ? const Color(0xFF6ebd99) : Colors.transparent,
                                  width: 6,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(users[index].imageUrl),
                                radius: 35,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${users[index].firstName} ${users[index].name}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: h * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const EnvoieScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child){
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                              );
                          }
                          )               
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)
                    ),
                    child: const Text('Annuler',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Confirmer
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: validColor,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)
                    ),
                    child: const Text('Confirmer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.025),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Numéro Orange du destinataire',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: descColor),
        ),
        const SizedBox(height: 8.0),
        TextField(
          cursorColor: primaryColor,
          controller: _recipientPhoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Numéro de téléphone',
            hintStyle: const TextStyle(color: descColor, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor),
            ),
            prefixIcon: _buildCountryCodePicker(),
          ),
        ),
      ],
    );
  }

  Widget _buildOrangePhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Votre numéro Orange',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextField(
          cursorColor: primaryColor,
          controller: _orangePhoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Numéro de téléphone',
            hintStyle: const TextStyle(color: descColor, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor),
            ),
            prefixIcon: _buildCountryCodePicker(),
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationPhoneField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextField(
          cursorColor: primaryColor,
          controller: _destinationPhoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Numéro de téléphone',
            hintStyle: const TextStyle(color: descColor, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: primaryColor),
            ),
            prefixIcon: _buildCountryCodePicker(),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCodePicker() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 8, right: 8),
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
          style: const TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}