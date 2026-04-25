import 'package:flutter/material.dart';

class TeacherDashboardCard extends StatelessWidget {
  const TeacherDashboardCard({
    super.key,
    required this.title,
    this.imageAsset,
    this.icon,
    this.outlined = false,
    this.onTap,
  });

  final String title;
  final String? imageAsset;
  final IconData? icon;
  final bool outlined;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = outlined
        ? const Color(0xFF3390FF)
        : const Color(0x16000000);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 172,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: outlined ? 2 : 1),
            boxShadow: outlined
                ? null
                : const [
                    BoxShadow(
                      color: Color(0x16000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: outlined ? Colors.white : const Color(0xFFF2F2F2),
                    child: imageAsset != null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                imageAsset!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              icon ?? Icons.dashboard_customize_outlined,
                              size: 44,
                              color: const Color(0xFF3390FF),
                            ),
                          ),
                  ),
                ),
                if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
