import 'package:flutter/material.dart';
 
class BulletItem extends StatelessWidget {
  final String text;
 
  const BulletItem(this.text, {super.key});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(Icons.circle, size: 5, color: Color(0xFF8A94A6)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 14.5, height: 1.55, color: Color(0xFF4A5568))),
          ),
        ],
      ),
    );
  }
}
 