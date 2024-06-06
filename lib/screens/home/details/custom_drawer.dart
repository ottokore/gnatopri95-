import 'package:dassi/auth/user_model.dart';
import 'package:dassi/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isDarkMode = false;

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
    final userModel = Provider.of<UserModel>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 9, 25, 105)),
            accountName: Text('${userModel.name} ${userModel.firstName}'),
            accountEmail: Text('${userModel.countryCode} ${userModel.phoneNumber}'),
            currentAccountPicture: userModel.photoUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userModel.photoUrl),
                  )
                : const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar1.png'),
                  ),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              // Naviguer vers la page d'accueil
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Portefeuille'),
            onTap: () {
              // Naviguer vers la page du portefeuille
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historique'),
            onTap: () {
              // Naviguer vers la page d'historique
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              // Naviguer vers la page des paramètres
            },
          ),
          SwitchListTile(
            title: Text(_isDarkMode ? 'Mode clair' : 'Mode sombre'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // Appliquer le mode sombre/clair
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              userModel.logout(); // Déconnecter l'utilisateur
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
}