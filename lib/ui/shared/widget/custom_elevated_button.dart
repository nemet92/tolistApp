import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.icon})
      : super(key: key);
  Function() onPressed;
  String text;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xffff973f)),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text));
  }
}
