import 'package:flutter/material.dart';

class PermissionButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const PermissionButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        
        onPressed: enabled ? onPressed : null, 
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return const Color(0xFF0084FF);
            },
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: const Text(
          "Start Exam",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}