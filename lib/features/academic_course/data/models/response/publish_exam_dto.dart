import 'package:close_gap/features/academic_course/domain/entities/publish_exam_academic_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publish_exam_dto.g.dart';

@JsonSerializable()
class PublishExamDto {
  @JsonKey(name: "academic_course_id")
  int? academicCourseId;
  @JsonKey(name: "academic_course_name")
  String? academicCourseName;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "duration_minutes")
  int? durationMinutes;
  @JsonKey(name: "ends_at")
  DateTime? endsAt;
  @JsonKey(name: "exam_type")
  String? examType;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_published")
  bool? isPublished;
  @JsonKey(name: "my_score")
  dynamic myScore;
  @JsonKey(name: "my_status")
  String? myStatus;
  @JsonKey(name: "passing_score")
  int? passingScore;
  @JsonKey(name: "question_count")
  int? questionCount;
  @JsonKey(name: "starts_at")
  DateTime? startsAt;
  @JsonKey(name: "teacher_id")
  int? teacherId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "total_marks")
  int? totalMarks;

  PublishExamDto({
    this.academicCourseId,
    this.academicCourseName,
    this.createdAt,
    this.description,
    this.durationMinutes,
    this.endsAt,
    this.examType,
    this.id,
    this.isPublished,
    this.myScore,
    this.myStatus,
    this.passingScore,
    this.questionCount,
    this.startsAt,
    this.teacherId,
    this.title,
    this.totalMarks,
  });

  factory PublishExamDto.fromJson(Map<String, dynamic> json) =>
      _$PublishExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PublishExamDtoToJson(this);
  PublishExamAcademicEntity toEntity() {
    return PublishExamAcademicEntity(
      academicCourseId: academicCourseId,
      academicCourseName: academicCourseName,
      createdAt: createdAt,
      description: description,
      durationMinutes: durationMinutes,
      endsAt: endsAt,
      examType: examType,
      id: id,
      isPublished: isPublished,
      myScore: myScore,
      myStatus: myStatus,
      passingScore: passingScore,
      questionCount: questionCount,
      startsAt: startsAt,
      teacherId: teacherId,
      title: title,
      totalMarks: totalMarks,
    );
  }
}
