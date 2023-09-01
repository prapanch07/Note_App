import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(yellowcolor),
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: blackcolor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
