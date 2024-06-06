import 'package:dassi/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: innerBoxIsScrolled ? primaryColor : bgColor,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0), // Padding en haut et en bas
                child: Image.asset(
                  innerBoxIsScrolled ? 'assets/images/logo.png' : 'assets/images/dassi_logo.png',
                  height: 40,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: FaIcon(FontAwesomeIcons.chevronLeft, size: 16,
                  color: innerBoxIsScrolled ? bgColor : primaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ];
        },
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Politique de confidentialité",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 20,),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "La présente Politique de Confidentialité décrit la manière dont Pixel Design collecte, utilise et protège les informations personnelles que vous fournissez lors de l'utilisation de l'application mobile Dassi.\n\n\n"
                      ),
                      TextSpan(
                        text: "1. Collecte d'Informations\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "1.1 Lors de votre inscription à l'Application, nous collectons les informations suivantes :\n\nVotre numéro de téléphone\n\nVotre code PIN\n\nLes informations de paiement lorsque vous effectuez des transactions via l'Application\n\n1.2 Nous pouvons également collecter des informations sur votre utilisation de l'Application, telles que les transactions effectuées, les pages visitées et les interactions avec l'interface de l'Application.\n\n"
                      ),
                      TextSpan(
                        text: "\n2. Utilisation des Informations\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "2.1 Les informations que nous collectons sont utilisées dans le but de :\n\nFournir les services demandés via l'Application, tels que les transferts d'argent et les achats de crédit airtime et de données mobiles\n\nAméliorer et personnaliser l'expérience utilisateur de l'Application\n\nRépondre à vos demandes d'assistance et de support\n\nSe conformer aux exigences légales et réglementaires\n\n"
                      ),
                      TextSpan(
                        text: "\n3. Protection des Informations\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "3.1 Nous prenons des mesures de sécurité appropriées pour protéger vos informations personnelles contre tout accès non autorisé, toute divulgation ou toute utilisation abusive.\n\n3.2 Votre code PIN est stocké de manière sécurisée et n'est pas accessible aux tiers.\n\n"
                      ),
                      TextSpan(
                        text: "\n4. Partage d'Informations\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "4.1 Nous ne partagerons pas vos informations personnelles avec des tiers, sauf dans les cas suivants :\n\nAvec votre consentement explicite\n\nLorsque cela est nécessaire pour fournir les services demandés via l'Application\n\nPour se conformer aux exigences légales et réglementaires\n\n"
                      ),
                      TextSpan(
                        text: "\n5. Conservation des Informations\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "5.1 Nous conserverons vos informations personnelles aussi longtemps que nécessaire pour remplir les objectifs décrits dans cette Politique de Confidentialité, à moins qu'une période de conservation plus longue ne soit requise ou autorisée par la loi.\n\n"
                      ),
                      TextSpan(
                        text: "\n6. Droits des Utilisateurs\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "6.1 Vous avez le droit d'accéder à vos informations personnelles, de les corriger, de les mettre à jour ou de les supprimer à tout moment. Vous pouvez exercer ces droits en nous contactant à customer@dassipay.com.\n\n"
                      ),
                      TextSpan(
                        text: "\n7. Modifications de la Politique de Confidentialité\n\n",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "7.1 Nous nous réservons le droit de modifier cette Politique de Confidentialité à tout moment. Les modifications prendront effet dès leur publication sur l'Application. Il est de votre responsabilité de consulter régulièrement cette Politique de Confidentialité pour rester informé de toute modification.\n\n"
                      ),
                      TextSpan(
                        text: "\n8. Contact\n\n",
                        style: TextStyle(
                          fontSize: 1,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "Si vous avez des questions ou des préoccupations concernant cette Politique de Confidentialité, veuillez nous contacter à customer@dassipay.com."
                      ),
                    ]
                  )
                )
              ],
            ),
          ),
        )
        )
    );
  }
}