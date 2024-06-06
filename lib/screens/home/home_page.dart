import 'package:dassi/auth/login.dart';
import 'package:dassi/auth/user_model.dart';
import 'package:dassi/screens/home/details/amount_widget.dart';
import 'package:dassi/screens/home/details/app_drawer.dart';
import 'package:dassi/screens/home/details/bottom_navigation.dart';
import 'package:dassi/screens/home/details/cartes_enregistres.dart';
import 'package:dassi/screens/home/details/home_payment_feature.dart';
import 'package:dassi/screens/home/details/home_payments.dart';
import 'package:dassi/screens/home/details/home_promotion.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dassi/screens/home/details/header.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _drawerKey = GlobalKey<SliderDrawerState>();

  @override
  void initState() {
    super.initState();
    // Vérifiez si l'utilisateur est authentifié
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (userModel.isAuthenticated) {
      // L'utilisateur est authentifié, chargez ses données si nécessaire
    } else {
      // L'utilisateur n'est pas authentifié, redirigez-le vers l'écran de connexion
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: AppDrawer(
        drawerKey: _drawerKey,
        child: Scaffold(
          backgroundColor: primaryColor,
          extendBody: true,
          body: Column(
            children: [
              HeaderScreen(drawerKey: _drawerKey),
              const AmountWidget(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        HomePayments(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomePaymentFeature(),
                                  SizedBox(height: 30.0,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Mes cartes de crédit",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CartesEnregistres(),
                                  HomePromotion(), 
                                ],
                              ),
                            )                    
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomNavigation(),
        ),
      ),
    );
  }
}