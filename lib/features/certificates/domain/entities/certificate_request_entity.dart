class CertificateRequestEntity {
  const CertificateRequestEntity({
    required this.title,
    required this.skillId,
    required this.courseId,
  });

  final String title;
  final int skillId;
  final int courseId;
}
