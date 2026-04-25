class ExperienceItem {
  const ExperienceItem({
    required this.id,
    required this.companyName,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.skills,
  });

  final int id;
  final String companyName;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final List<String> skills;
}
