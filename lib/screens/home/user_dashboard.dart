import 'package:dassi/auth/user_model.dart';
import 'package:dassi/screens/home/details/amount_widget.dart';
import 'package:dassi/screens/home/details/bottom_navigation.dart';
import 'package:dassi/screens/home/details/cartes_enregistres.dart';
import 'package:dassi/screens/home/details/custom_drawer.dart';
import 'package:dassi/screens/home/details/header_home.dart';
import 'package:dassi/screens/home/details/home_payment_feature.dart';
import 'package:dassi/screens/home/details/home_payments.dart';
import 'package:dassi/screens/home/details/home_promotion.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    await userModel.loadUserData();
  }
  

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: _scaffoldKey, // Assigner la clé au Scaffold
        backgroundColor: primaryColor,
        extendBody: true,
        drawer: const CustomDrawer(), // Inclure le drawer ici
        body: Column(
          children: [
            HeaderHome(
              onMenuTap: () {
                // Ouvrir le drawer lorsque onMenuTap est appelé
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
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
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HomePaymentFeature(),
                                SizedBox(height: 30.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Mes cartes de crédit",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CartesEnregistres(),
                                HomePromotion(),
                              ],
                            ),
                          ),
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
    );
  }
}