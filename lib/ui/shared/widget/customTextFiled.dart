import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled({
    required this.controller,
    required this.hintText,
    Key? key,
  }) : super(key: key);
  String hintText;

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder()),
    );
  }
}
