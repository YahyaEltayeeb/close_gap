class ProjectDto {
  final int? id;
  final String? title;
  final String? description;
  final String? githubUrl;
  final String? demoUrl;
  final List<String>? skills;

  const ProjectDto({
    required this.id,
    required this.title,
    required this.description,
    required this.githubUrl,
    required this.demoUrl,
    required this.skills,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      githubUrl: json['github_url'] as String?,
      demoUrl: json['demo_url'] as String?,
      skills: (json['skills'] as List<dynamic>? ?? const [])
          .map((skill) => skill.toString())
          .toList(),
    );
  }
}
