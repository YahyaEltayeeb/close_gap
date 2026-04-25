import 'package:flutter/material.dart';

class TeacherBottomNavigation extends StatelessWidget {
  const TeacherBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 8, 22, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0x1A000000))),
      ),
      child: const SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TeacherBottomNavigationItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: true,
            ),
            TeacherBottomNavigationItem(
              icon: Icons.person_outline,
              label: 'My profile',
            ),
            TeacherBottomNavigationItem(
              icon: Icons.notifications_none_outlined,
              label: 'Notifications',
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherBottomNavigationItem extends StatelessWidget {
  const TeacherBottomNavigationItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? const Color(0xFF202124)
        : const Color(0xFF949494);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 31, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
