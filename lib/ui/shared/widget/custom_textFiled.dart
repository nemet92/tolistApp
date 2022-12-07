import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled({
    required this.controller,
    required this.hintText,
    required this.validate,
    required this.errorText,
    this.keypoardType,
    Key? key,
  }) : super(key: key);
  String hintText;
  bool validate;
  String errorText;
  TextInputType? keypoardType;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keypoardType,
      controller: controller,
      decoration: InputDecoration(
          errorText: validate ? errorText : null,
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder()),
    );
  }
}
