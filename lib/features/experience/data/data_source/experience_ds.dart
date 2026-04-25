import 'package:close_gap/features/experience/data/model/request/experience_request_dto.dart';
import 'package:close_gap/features/experience/data/model/response/experience_dto.dart';

abstract class ExperienceDs {
  Future<List<ExperienceDto>> getExperiences();

  Future<void> createExperience(ExperienceRequestDto requestDto);

  Future<void> updateExperience(
    int experienceId,
    ExperienceRequestDto requestDto,
  );

  Future<void> deleteExperience(int experienceId);
}
