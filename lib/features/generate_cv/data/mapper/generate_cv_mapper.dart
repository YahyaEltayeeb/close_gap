import 'package:close_gap/features/generate_cv/data/model/request/generate_cv_request_dto.dart';
import 'package:close_gap/features/generate_cv/domain/entities/generate_cv_request_entity.dart';

extension GenerateCvRequestMapper on GenerateCvRequestEntity {
  GenerateCvRequestDto toDto() {
    return GenerateCvRequestDto(
      name: name,
      jobTitle: jobTitle,
      email: email,
      phone: phone,
      address: address,
      linkedin: linkedin,
      github: github,
      skills: skills,
      experience: experience
          .map(
            (entry) => CvExperienceEntryDto(
              role: entry.role,
              company: entry.company,
              location: entry.location,
              duration: entry.duration,
              responsibilities: entry.responsibilities,
            ),
          )
          .toList(),
      education: education
          .map(
            (entry) => CvEducationEntryDto(
              degree: entry.degree,
              institution: entry.institution,
              duration: entry.duration,
            ),
          )
          .toList(),
      courses: courses,
      languages: languages,
    );
  }
}
