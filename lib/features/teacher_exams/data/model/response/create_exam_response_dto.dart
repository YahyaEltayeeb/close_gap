class AcademicExamDto {
  final int? id;
  final int? academicCourseId;
  final String? academicCourseName;
  final String? title;
  final String? examType;
  final int? durationMinutes;
  final double? passingScore;
  final double? totalMarks;
  final String? startsAt;
  final String? endsAt;
  final bool? isPublished;
  final int? questionCount;

  const AcademicExamDto({
    required this.id,
    required this.academicCourseId,
    required this.academicCourseName,
    required this.title,
    required this.examType,
    required this.durationMinutes,
    required this.passingScore,
    required this.totalMarks,
    required this.startsAt,
    required this.endsAt,
    required this.isPublished,
    required this.questionCount,
  });

  factory AcademicExamDto.fromJson(Map<String, dynamic> json) {
    return AcademicExamDto(
      id: json['id'] as int?,
      academicCourseId: json['academic_course_id'] as int?,
      academicCourseName: json['academic_course_name'] as String?,
      title: json['title'] as String?,
      examType: json['exam_type'] as String?,
      durationMinutes: json['duration_minutes'] as int?,
      passingScore: (json['passing_score'] as num?)?.toDouble(),
      totalMarks: (json['total_marks'] as num?)?.toDouble(),
      startsAt: json['starts_at'] as String?,
      endsAt: json['ends_at'] as String?,
      isPublished: json['is_published'] as bool?,
      questionCount: json['question_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'academic_course_id': academicCourseId,
      'academic_course_name': academicCourseName,
      'title': title,
      'exam_type': examType,
      'duration_minutes': durationMinutes,
      'passing_score': passingScore,
      'total_marks': totalMarks,
      'starts_at': startsAt,
      'ends_at': endsAt,
      'is_published': isPublished,
      'question_count': questionCount,
    };
  }
}

class CreateExamResponseDto {
  final AcademicExamDto exam;
  final bool ok;

  const CreateExamResponseDto({required this.exam, required this.ok});

  factory CreateExamResponseDto.fromJson(Map<String, dynamic> json) {
    return CreateExamResponseDto(
      exam: AcademicExamDto.fromJson(json['exam'] as Map<String, dynamic>),
      ok: json['ok'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'exam': exam.toJson(), 'ok': ok};
  }
}
