import 'package:flutter/material.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 85,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage('images/dp.jpg'),
            ),
          ),
          Center(
              child: Text(
            'Samantha Shenoy',
            style: TextStyle(fontSize: 20),
          )),
        ],
      ),
    );
  }
}
