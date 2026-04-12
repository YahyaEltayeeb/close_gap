import 'package:flutter/material.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.warning, color: Colors.amber),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "You cannot continue unless permissions are granted.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}