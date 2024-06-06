import 'package:dassi/screens/home/home_page.dart';
import 'package:dassi/screens/welcome.dart';
import 'package:dassi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<SliderDrawerState> drawerKey;
  final Widget child;
  final Widget? slider;

  const AppDrawer({
    super.key,
    required this.drawerKey,
    required this.child,
    this.slider,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isDarkMode = false;

  Widget _buildDrawerContent() {
    return Container(
      color: bgColor,
      child: Column(
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/avatar1.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '+1 (123) 456-7890',
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.home, color: primaryColor),
            title: const Text('Accueil', style: TextStyle(color: primaryColor)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          // Autres éléments du menu...
          ListTile(
            leading: const Icon(Icons.dark_mode, color: primaryColor),
            title: const Text('Mode Sombre', style: TextStyle(color: primaryColor)),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: primaryColor),
            title: const Text('Se déconnecter', style: TextStyle(color: primaryColor)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      key: widget.drawerKey,
      appBar: SliderAppBar(
        appBarColor: bgColor,
        title: const Text(
          'Retour',
          style: TextStyle(color: primaryColor, fontSize: 18),
        ),
        trailing: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
          onPressed: () {
            widget.drawerKey.currentState?.closeSlider();
          },
        ),
      ),
      slider: widget.slider ?? _buildDrawerContent(),
      child: widget.child,
    );
  }
}