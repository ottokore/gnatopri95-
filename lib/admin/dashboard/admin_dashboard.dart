import 'package:dassi/Widgets/custom_btn.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'admin_header.dart';
import 'admin_body.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const AdminHeader(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'Utilisateurs récents',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  AdminBody(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: h*0.07,
                        child: CustomBtn(
                          text: "Tous les utilisateurs",
                          onPressed: () {
                            //
                          }
                        ),
                      ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}