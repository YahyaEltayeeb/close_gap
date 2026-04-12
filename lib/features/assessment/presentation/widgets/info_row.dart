import 'package:flutter/material.dart';
 
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
 
  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
 
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFDDEEFD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF2D7FEA), size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black87)),
              const SizedBox(height: 3),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF8A94A6), height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}
 