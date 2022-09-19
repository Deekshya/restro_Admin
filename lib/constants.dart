import 'dart:collection';

import 'package:flutter/material.dart';

const kInputTextDecorationBorder = InputDecoration(
  hintText: '',
  //hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kPrimLightColor = Color(0x80e3d2f5);
const kPrimDarkColor = Color(0xFF300636);
List<BoxShadow> customShadow = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: -5,
      offset: const Offset(-5, -5),
      blurRadius: 30),
  BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      offset: const Offset(7, 7),
      blurRadius: 20),
];

ButtonStyle kOutlinedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(Colors.purple),
  side:
      MaterialStateProperty.all<BorderSide>(BorderSide(color: kPrimDarkColor)),
  shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
  shadowColor: MaterialStateProperty.all(Colors.purple),
  //elevation: MaterialStateProperty.all(1)
);

List<String> category = [];
Map<String, dynamic> categoryData = {};
String defaultImageUrl =
    "https://firebasestorage.googleapis.com/v0/b/fir-at-a219d.appspot.com/o/DefaultImages%2Fbeef-sausages.jpg?alt=media&token=7fcc1b42-f63c-4176-8389-b3a26234bd7d";
final categoryNameController = TextEditingController();
final itemNameController = TextEditingController();
final itemPriceController = TextEditingController();
final itemDescriptionController = TextEditingController();
final imageSelected = defaultImageUrl;
