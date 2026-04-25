class ProjectEntity {
  final int id;
  final String title;
  final String description;
  final String githubUrl;
  final String demoUrl;
  final List<String> skills;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.githubUrl,
    required this.demoUrl,
    required this.skills,
  });
}
