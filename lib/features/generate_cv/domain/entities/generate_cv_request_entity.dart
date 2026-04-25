class GenerateCvRequestEntity {
  const GenerateCvRequestEntity({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.address,
    required this.linkedin,
    required this.github,
    required this.skills,
    required this.experience,
    required this.education,
    required this.courses,
    required this.languages,
  });

  final String name;
  final String jobTitle;
  final String email;
  final String phone;
  final String address;
  final String linkedin;
  final String github;
  final List<String> skills;
  final List<CvExperienceEntryEntity> experience;
  final List<CvEducationEntryEntity> education;
  final List<String> courses;
  final String languages;
}

class CvExperienceEntryEntity {
  const CvExperienceEntryEntity({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.responsibilities,
  });

  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> responsibilities;
}

class CvEducationEntryEntity {
  const CvEducationEntryEntity({
    required this.degree,
    required this.institution,
    required this.duration,
  });

  final String degree;
  final String institution;
  final String duration;
}
