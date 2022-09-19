import 'package:flutter/material.dart';
import 'package:restro_admin/constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(kPrimLightColor),
          elevation: MaterialStateProperty.all(1),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)))),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: kPrimLightColor,
        child: Icon(
          Icons.person_pin,
          color: kPrimDarkColor,
          size: 50,
        ),
      ),
    );
  }
}
