import 'package:flutter/material.dart';
import 'package:restro_admin/components/reusable_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restro_admin/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restro_admin/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firebase = FirebaseFirestore.instance;
  final String uniqueKey = 'sms1234';
  late final userRoot;

  String email = '';
  String password = '';

  @override
  void initState() {
    userRoot = FirebaseFirestore.instance
        .collection('OwnerData')
        .doc(uniqueKey)
        .collection("Menu")
        .doc("hotelMenu");

    super.initState();
  }

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
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
              height: 24.0,
            ),
            ReusableButton(
              color: Colors.lightBlueAccent,
              label: 'Register',
              onPress: () async {
                //add the data to auth db

                try {
                  final user = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  print('user...b4');

                  if (user != null) {
                    print('user...i');
                    //add the unique key to userdata
                    // DocumentReference doc =
                    //     _firebase.collection("Menu").doc("hotelMenu");
                    await userRoot
                        .set({"dataa": {}})
                        .then((value) => print("User Key Added"))
                        .catchError(
                            (error) => print("Failed to add User Key: $error"));
                    print('user...2');
                    //navigate to homescreen
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
