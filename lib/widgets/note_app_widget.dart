import 'package:flutter/material.dart';

import '../colors.dart';

class NoteAppWidget extends StatelessWidget {
  const NoteAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'NoteApp',
        style: TextStyle(
          color: backgroundcolor,
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      ),
    );
  }
}
