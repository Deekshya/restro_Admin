import 'package:flutter/material.dart';
import 'package:restro_admin/components/reusable_button.dart';
import 'package:restro_admin/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restro_admin/screens/home_screen.dart';
import 'package:restro_admin/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = "login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  bool spinnerValue = false;
  Color primaryColor = Color(0xff00B7EB);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 200.0,
                child: SvgPicture.asset(
                  'images/login.svg',
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                cursorColor: Colors.purple,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputTextDecorationBorder.copyWith(
                    hintText: 'Enter your Email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                cursorColor: Colors.purple,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputTextDecorationBorder.copyWith(
                    hintText: 'Enter your Password')),
            SizedBox(
              height: 24.0,
            ),
            ReusableButton(
              color: Colors.purple,
              label: 'Log In',
              onPress: () async {
                setState(() {
                  spinnerValue = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);

                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Successful!')));
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                  setState(() {
                    spinnerValue = false;
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User Not Found')));
                  }
                  if (e.code == 'wrong-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wrong Password')));
                  }
                  if (e.code == 'unknown') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Enter email id and Password to Login!')));
                  }
                  print(e.code);
                }
              },
            ),
            SizedBox(
              height: 14.0,
            ),
            ReusableButton(
              color: Colors.purple,
              label: 'New User? Sign Up Now!',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
