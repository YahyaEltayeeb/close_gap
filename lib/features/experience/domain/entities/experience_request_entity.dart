class ExperienceRequestEntity {
  const ExperienceRequestEntity({
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
}
