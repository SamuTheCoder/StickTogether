import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const DefaultTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber)),
          hintText: hintText,
        ),
      ),
    );
  }
}
