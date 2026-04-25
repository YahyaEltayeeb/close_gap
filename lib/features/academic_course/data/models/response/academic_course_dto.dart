import 'package:close_gap/features/academic_course/domain/entities/academic_course_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'academic_course_dto.g.dart';


@JsonSerializable()
class AcademicCourseDto {
    @JsonKey(name: "code")
    String? code;
    @JsonKey(name: "created_at")
    DateTime? createdAt;
    @JsonKey(name: "curriculum_year")
    int? curriculumYear;
    @JsonKey(name: "department_id")
    int? departmentId;
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "semester")
    int? semester;
    @JsonKey(name: "skills")
    String? skills;

    AcademicCourseDto({
        this.code,
        this.createdAt,
        this.curriculumYear,
        this.departmentId,
        this.id,
        this.name,
        this.semester,
        this.skills,
    });

    factory AcademicCourseDto.fromJson(Map<String, dynamic> json) => _$AcademicCourseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$AcademicCourseDtoToJson(this);

    AcademicCourseEntity toEntity() {
    return AcademicCourseEntity(
      code: code,
      createdAt: createdAt,
      curriculumYear: curriculumYear,
      departmentId: departmentId,
      id: id,
      name: name,
      semester: semester,
      skills: skills,
    );
  }
}
