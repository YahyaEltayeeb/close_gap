class CertificateItem {
  const CertificateItem({
    required this.id,
    required this.title,
    required this.skillId,
    required this.courseId,
    required this.issuedAt,
    required this.provider,
    required this.credentialUrl,
  });

  final int id;
  final String title;
  final int skillId;
  final int courseId;
  final DateTime? issuedAt;
  final String? provider;
  final String? credentialUrl;
}
