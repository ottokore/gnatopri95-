// routes.dart
import 'package:dassi/screens/routes/banque_screen.dart';
import 'package:dassi/screens/routes/carte_screen.dart';
import 'package:dassi/screens/routes/depot_screen.dart';
import 'package:dassi/screens/routes/envoie_screen.dart';
import 'package:dassi/screens/routes/facture_screen.dart';
import 'package:dassi/screens/routes/mobile_screen.dart';
import 'package:dassi/screens/routes/numero_virtuel_screen.dart';
import 'package:dassi/screens/routes/retrait_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/depot': (BuildContext context) => const DepotScreen(),
  '/envoie': (BuildContext context) => const EnvoieScreen(),
  '/retrait': (BuildContext context) => const RetraitScreen(),
  '/mobile': (BuildContext context) => const MobileScreen(),
  '/carte': (BuildContext context) => const CarteScreen(),
  '/facture': (BuildContext context) => const FactureScreen(),
  '/numero_virtuel': (BuildContext context) => const NumeroVirtuelScreen(),
  '/banque': (BuildContext context) => const BanqueScreen(),
};