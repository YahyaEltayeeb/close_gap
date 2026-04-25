import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/presentation/helpers/certificate_date_formatter.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:flutter/material.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    super.key,
    required this.certificate,
    required this.skills,
    required this.courses,
  });

  final CertificateItem certificate;
  final List<SkillEntity> skills;
  final List<CourseOptionEntity> courses;

  @override
  Widget build(BuildContext context) {
    final skillName = _skillName(certificate.skillId);
    final courseName = _courseName(certificate.courseId);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            certificate.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          _InfoRow(label: 'Skill', value: skillName),
          const SizedBox(height: 6),
          _InfoRow(label: 'Course', value: courseName),
          const SizedBox(height: 6),
          _InfoRow(
            label: 'Issued at',
            value: formatCertificateDate(certificate.issuedAt),
          ),
        ],
      ),
    );
  }

  String _skillName(int id) {
    return skills.where((item) => item.id == id).firstOrNull?.name ??
        'Skill #$id';
  }

  String _courseName(int id) {
    return courses.where((item) => item.id == id).firstOrNull?.name ??
        'Course #$id';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
