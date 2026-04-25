import 'package:close_gap/features/teacher_past_exams/data/model/response/teacher_exam_list_item_dto.dart';
import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';

extension TeacherExamListItemDtoMapper on TeacherExamListItemDto {
  TeacherExamListItemEntity toEntity() {
    return TeacherExamListItemEntity(
      id: id ?? 0,
      academicCourseId: academicCourseId ?? 0,
      academicCourseName: (academicCourseName ?? '').trim(),
      title: (title ?? '').trim(),
      examType: (examType ?? '').trim(),
      durationMinutes: durationMinutes ?? 0,
      passingScore: passingScore ?? 0,
      totalMarks: totalMarks ?? 0,
      startsAt: startsAt ?? '',
      endsAt: endsAt ?? '',
      isPublished: isPublished ?? false,
      questionCount: questionCount ?? 0,
    );
  }
}
