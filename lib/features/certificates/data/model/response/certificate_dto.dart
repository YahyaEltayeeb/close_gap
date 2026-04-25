class CertificateDto {
  const CertificateDto({
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
  final String? issuedAt;
  final String? provider;
  final String? credentialUrl;

  factory CertificateDto.fromJson(Map<String, dynamic> json) {
    return CertificateDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      skillId: (json['skill_id'] as num?)?.toInt() ?? 0,
      courseId: (json['course_id'] as num?)?.toInt() ?? 0,
      issuedAt: json['issued_at']?.toString(),
      provider: json['provider']?.toString(),
      credentialUrl: json['credential_url']?.toString(),
    );
  }
}
