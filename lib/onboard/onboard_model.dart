import 'package:flutter/material.dart';
import 'package:dassi/utils/utils.dart';

class OnboardModel {
  late String img;
  late String text;
  late String desc;
  late Color bg;
  late Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: 'assets/screen1.png', 
    text: "Transfert d'argent international", 
    desc: "Envoyez de l'argent partout dans le monde, en toute simplicité. Aucune limite de réseau.", 
    bg: Colors.white, 
    button: primaryColor,
    ),

    OnboardModel(
    img: 'assets/screen2.png', 
    text: "Rechargez, payez, partagez entre amis", 
    desc: "Rechargez votre compte Mobile Money ou celui d'un ami peu importe le réseau.", 
    bg: Colors.white, 
    button: primaryColor,
    ),

    OnboardModel(
    img: 'assets/screen3.png', 
    text: "Carte virtuelle, achats réels sécurisés", 
    desc: "Obtenez votre carte de crédit virtuelle en un clin d'œil. Effectuez des paiements sécurisés en ligne.", 
    bg: Colors.white, 
    button: primaryColor,
    ),

    OnboardModel(
    img: 'assets/screen4.png', 
    text: "Crédit d'appel et Data internet tous réseaux", 
    desc: "Acheter du crédit d'appel ou Data internet d'un réseau mobile à un autre en toute simplicité.", 
    bg: Colors.white, 
    button: primaryColor,
    ),
];
