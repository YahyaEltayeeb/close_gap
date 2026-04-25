class ExperienceRequestDto {
  const ExperienceRequestDto({
    required this.companyName,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.skills,
  });

  final String companyName;
  final String title;
  final String startDate;
  final String? endDate;
  final String description;
  final List<String> skills;

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'skills': skills,
    };
  }
}
