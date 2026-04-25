class GenerateCvRequestDto {
  const GenerateCvRequestDto({
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
  final List<CvExperienceEntryDto> experience;
  final List<CvEducationEntryDto> education;
  final List<String> courses;
  final String languages;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job_title': jobTitle,
      'email': email,
      'phone': phone,
      'address': address,
      'linkedin': linkedin,
      'github': github,
      'skills': skills,
      'experience': experience.map((entry) => entry.toJson()).toList(),
      'education': education.map((entry) => entry.toJson()).toList(),
      'courses': courses,
      'languages': languages,
    };
  }
}

class CvExperienceEntryDto {
  const CvExperienceEntryDto({
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

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'company': company,
      'location': location,
      'duration': duration,
      'responsibilities': responsibilities,
    };
  }
}

class CvEducationEntryDto {
  const CvEducationEntryDto({
    required this.degree,
    required this.institution,
    required this.duration,
  });

  final String degree;
  final String institution;
  final String duration;

  Map<String, dynamic> toJson() {
    return {'degree': degree, 'institution': institution, 'duration': duration};
  }
}
