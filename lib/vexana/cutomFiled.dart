import 'package:flutter/material.dart';

class CustomUserLoginField extends StatelessWidget {
  const CustomUserLoginField({
    Key? key,
    required this.controller,
    required this.validate,
    this.textAction = TextInputAction.next,
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?) validate;
  final TextInputAction textAction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textInputAction: textAction,
        controller: controller,
        validator: validate,
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder()),
      ),
    );
  }
}
