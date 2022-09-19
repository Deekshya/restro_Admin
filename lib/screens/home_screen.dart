import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restro_admin/constants.dart';
import 'package:restro_admin/screens/home_page_drawer.dart';
import 'package:restro_admin/components/order_card.dart';
import 'package:restro_admin/screens/set_menu_screen.dart';

/*
This is the screen which will be first show to the restaurant owner once logged in
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser;
  String userEmail = '';
  String status = 'NEW';

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      loggedInUser = _auth.currentUser;
      if (loggedInUser != null) {
        print(loggedInUser!.email);
        userEmail = loggedInUser!.email!;
        print(userEmail);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePageDrawer(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: [Colors.white, kPrimDarkColor],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter)),
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: customShadow,
                          color: kPrimLightColor,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: kPrimDarkColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.person_pin,
                                color: kPrimDarkColor,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.05),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            )
                          ]),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SetMenuScreen.id);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: const Text(
                          'SET MENU',
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              color: Colors.purple),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Orders',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: kPrimDarkColor),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(),
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => GestureDetector(
                              child: OrderCard(
                                status: status,
                                index: index,
                              ),
                              onTap: () {
                                print('Table No ${index + 1} clicked');
                              },
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
