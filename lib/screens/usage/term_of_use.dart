import 'package:dassi/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

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
                  color: innerBoxIsScrolled ? bgColor : Colors.black,
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
                  "Conditions Générales",
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
                        text: "Les présentes Conditions Générales d'Utilisation (ci-après dénommées \"CGU\") régissent l'utilisation de l'application mobile Dassi fournie par Pixel Design. En utilisant cette Application, vous acceptez les présentes CGU dans leur intégralité. Si vous n'acceptez pas ces termes, veuillez ne pas utiliser notre Application.\n\n"
                      ),
                      TextSpan(
                        text: "\n1. Description du Service\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "Dassi est une plateforme permettant à ses utilisateurs de réaliser des transferts d'argent mobile, d'acheter du crédit airtime et des données mobiles via une interface conviviale et sécurisée.\n\n"
                      ),
                      TextSpan(
                        text: "\n2. Inscription et Compte Utilisateur\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "2.1 Pour utiliser l'Application, vous devez vous inscrire en fournissant votre numéro de téléphone et en définissant un code PIN sécurisé. Vous êtes responsable de maintenir la confidentialité de votre code PIN et de toutes les activités qui se produisent sous votre compte.\n\n2.2 Vous acceptez de fournir des informations exactes, complètes et à jour lors de votre inscription et de mettre à jour ces informations au besoin.\n\n"
                      ),
                      TextSpan(
                        text: "\n3. Utilisation du Service\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "3.1 Vous acceptez d'utiliser l'Application uniquement à des fins légales et conformément à ces CGU.\n\n3.2 Vous acceptez de ne pas utiliser l'Application d'une manière qui pourrait compromettre sa sécurité, sa stabilité ou son accessibilité.\n\n3.3 Vous acceptez de ne pas utiliser l'Application pour des activités frauduleuses, illégales ou contraires à l'éthique.\n\n"
                      ),
                      TextSpan(
                        text: "\n4. Transferts d'Argent et Achats\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "4.1 Les transferts d'argent effectués via l'Application sont soumis aux frais et conditions indiqués lors de la transaction.\n\n4.2 Les achats de crédit airtime et de données mobiles sont non remboursables.\n\n"
                      ),
                      TextSpan(
                        text: "\n5. Sécurité\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "5.1 Nous prenons la sécurité de vos informations au sérieux. Cependant, vous reconnaissez et acceptez que la transmission de données via Internet n'est pas totalement sécurisée et que nous ne pouvons garantir la sécurité de vos informations transmises à travers l'Application.\n\n"
                      ),
                      TextSpan(
                        text: "\n6. Limitation de Responsabilité\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "6.1 Nous ne serons pas responsables des pertes ou dommages directs, indirects, spéciaux, consécutifs ou punitifs résultant de l'utilisation ou de l'impossibilité d'utiliser l'Application.\n\n"
                      ),
                      TextSpan(
                        text: "\n7. Modifications des CGU\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "7.1 Nous nous réservons le droit de modifier ces CGU à tout moment. Les modifications prendront effet dès leur publication sur l'Application. Il est de votre responsabilité de consulter régulièrement ces CGU pour rester informé de toute modification.\n\n"
                      ),
                      TextSpan(
                        text: "\n8. Résiliation\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "8.1 Nous nous réservons le droit de résilier votre accès à l'Application à tout moment et pour quelque raison que ce soit, sans préavis.\n\n"
                      ),
                      TextSpan(
                        text: "\n9. Droit Applicable et Règlement des Différends\n\n",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        )
                      ),
                      TextSpan(
                        text: "9.1 Ces CGU sont régies et interprétées conformément aux lois en vigueur dans votre pays de résidence. Tout différend découlant de ou lié à ces CGU sera soumis à la juridiction exclusive des tribunaux compétents de votre pays de résidence.\n\n"
                      ),
                      TextSpan(
                        text: "En utilisant l'Application, vous acceptez ces Conditions Générales d'Utilisation. Si vous avez des questions concernant ces CGU, veuillez nous contacter customer@dassipay.com."
                      ),
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}