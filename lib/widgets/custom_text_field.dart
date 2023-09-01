import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardtype;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardtype,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundcolor,
        border: Border.all(color: yellowcolor, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          style: const TextStyle(fontWeight: FontWeight.bold),
          keyboardType: keyboardtype,
        ),
      ),
    );
  }
}
