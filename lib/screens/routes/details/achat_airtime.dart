import 'package:dassi/screens/routes/details/achat_credit.dart';
import 'package:dassi/screens/routes/details/achat_data.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchatAirtime extends StatefulWidget {
  const AchatAirtime({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AchatAirtimeState createState() => _AchatAirtimeState();
}

class _AchatAirtimeState extends State<AchatAirtime> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: h*0.07,
              )
              ),
            Text(
              "Recharge airtime",
              style: TextStyle(
                  fontSize: w*0.053,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Achetez de crédits de communication ou datas internet en toute simplicité.",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: descColor,
                ),
                textAlign: TextAlign.center,
            ),
            SizedBox(height: h*0.06),

            Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AchatCredit()),
                          );
                        },
                        child: _buildImageButton('assets/images/phone-call.png', 'Achat de crédit'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AchatData()),
                          );
                        },
                        child: _buildImageButton('assets/images/internet.png', 'Achat de data'),
                      ),
                      
                    ],
                  ),
                ],
              ),
          ],
        ),
        ),
      ),
    );
  }


  Widget _buildImageButton(String imagePath, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8), // Spacing between image and text
        Text(
          label,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}