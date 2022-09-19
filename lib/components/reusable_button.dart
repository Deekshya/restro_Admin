import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPress;

  ReusableButton(
      {required this.label, required this.color, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPress,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
