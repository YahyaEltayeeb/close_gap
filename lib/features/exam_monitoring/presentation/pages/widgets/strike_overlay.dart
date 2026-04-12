import 'package:flutter/material.dart';

class StrikeOverlay extends StatelessWidget {
  final int strikes;

  const StrikeOverlay({super.key, required this.strikes});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.2),
      child: Center(
        child: Text(
          "Warning: Strike $strikes",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}