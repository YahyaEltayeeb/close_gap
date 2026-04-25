class CreateCertificateRequestDto {
  const CreateCertificateRequestDto({
    required this.title,
    required this.skillId,
    required this.courseId,
  });

  final String title;
  final int skillId;
  final int courseId;

  Map<String, dynamic> toJson() {
    return {'title': title, 'skill_id': skillId, 'course_id': courseId};
  }
}
