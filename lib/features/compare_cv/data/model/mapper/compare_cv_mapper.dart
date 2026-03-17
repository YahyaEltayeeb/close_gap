import 'package:close_gap/features/compare_cv/data/model/response/compare_cv_response_dto.dart';
import 'package:close_gap/features/compare_cv/domain/entities/compare_cv_result_entity.dart';

extension CompareCvMapper on CompareCvResponseDto {
  CompareCvResultEntity toEntity() {
    return CompareCvResultEntity(
      score: score,
      matchedSkills: matchedSkills,
      unmatchedSkills: unmatchedSkills,
      experienceMatch: experienceMatch,
      educationMatch: educationMatch,
      analysis: analysis,
      hrEmail: hrEmail,
    );
  }
}
