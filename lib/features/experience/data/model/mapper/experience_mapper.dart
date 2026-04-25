import 'package:close_gap/features/experience/data/model/request/experience_request_dto.dart';
import 'package:close_gap/features/experience/data/model/response/experience_dto.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';

extension ExperienceRequestEntityMapper on ExperienceRequestEntity {
  ExperienceRequestDto toDto() {
    return ExperienceRequestDto(
      companyName: companyName,
      title: title,
      startDate: startDate,
      endDate: endDate,
      description: description,
      skills: skills,
    );
  }
}

extension ExperienceDtoMapper on ExperienceDto {
  ExperienceItem toEntity() {
    DateTime parseDate(String? value) {
      return DateTime.tryParse(value ?? '') ?? DateTime(2000);
    }

    return ExperienceItem(
      id: id,
      companyName: companyName,
      title: title,
      startDate: parseDate(startDate),
      endDate: endDate == null ? null : parseDate(endDate),
      description: description,
      skills: skills,
    );
  }
}
