import 'package:dassi/auth/user_model.dart';
import 'package:dassi/firebase_options.dart';
import 'package:dassi/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dassi/utils/utils.dart';
import 'package:dassi/onboard/onboard.dart';
import 'package:dassi/auth/register.dart';
import 'package:dassi/auth/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = UserModel(); // Créez une instance de UserModel

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => userModel), // Fournissez UserModel
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(userModel)), // Passez UserModel à AuthProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dassi Payment',
        home: isViewed != 0 ? const Onboard() : const WelcomeScreen(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var screens = [
    const Register(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
    );
  }
}
