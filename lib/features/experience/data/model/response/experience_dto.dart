class ExperienceDto {
  const ExperienceDto({
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
  final String startDate;
  final String? endDate;
  final String description;
  final List<String> skills;

  factory ExperienceDto.fromJson(Map<String, dynamic> json) {
    final rawSkills = json['skills'];
    return ExperienceDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      companyName: json['company_name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      startDate: json['start_date']?.toString() ?? '',
      endDate: json['end_date']?.toString(),
      description: json['description']?.toString() ?? '',
      skills: rawSkills is List
          ? rawSkills.map((skill) => skill.toString()).toList()
          : const [],
    );
  }
}
