import 'package:flutter/material.dart';
import 'package:restro_admin/screens/home_screen.dart';
import 'package:restro_admin/screens/login_screen.dart';
import 'package:restro_admin/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restro_admin/screens/set_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SetMenuScreen.id: (context) => SetMenuScreen()
      },
    );
  }
}
