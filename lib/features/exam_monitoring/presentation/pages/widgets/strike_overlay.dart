import 'package:flutter/material.dart';

class StrikeOverlay extends StatelessWidget {
  final int strikes;
  final String reason;

  const StrikeOverlay({
    super.key,
    required this.strikes,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.2),
      child: Center(
        child: Text(
          "Warning $strikes/3\n$reason",
          textAlign: TextAlign.center,
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