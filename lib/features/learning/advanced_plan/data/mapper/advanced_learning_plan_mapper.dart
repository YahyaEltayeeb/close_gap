import 'package:close_gap/features/learning/advanced_plan/data/models/request/advanced_learning_plan_request_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/data/models/response/advanced_learning_plan_response_dto.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_entity.dart';
import 'package:close_gap/features/learning/advanced_plan/domain/entities/advanced_learning_plan_request_entity.dart';

extension AdvancedLearningPlanRequestMapper
    on AdvancedLearningPlanRequestEntity {
  AdvancedLearningPlanRequestDto toDto() {
    return AdvancedLearningPlanRequestDto(trackId: trackId);
  }
}

extension AdvancedLearningPlanResponseMapper
    on AdvancedLearningPlanResponseDto {
  AdvancedLearningPlanEntity toEntity() {
    return AdvancedLearningPlanEntity(
      ok: ok,
      trackId: trackId,
      roadmap: roadmap.map((week) => week.toEntity()).toList(),
    );
  }
}

extension RoadmapWeekMapper on RoadmapWeekDto {
  RoadmapWeekEntity toEntity() {
    return RoadmapWeekEntity(
      week: week,
      phase: phase,
      hours: hours,
      skills: skills,
      kpis: kpis,
      courses: courses.map((course) => course.toEntity()).toList(),
    );
  }
}

extension RoadmapCourseMapper on RoadmapCourseDto {
  RoadmapCourseEntity toEntity() {
    return RoadmapCourseEntity(
      id: id,
      title: title,
      level: level,
      type: type,
      url: url,
      freeLink: freeLink,
      paidLink: paidLink,
      weight: weight,
    );
  }
}
