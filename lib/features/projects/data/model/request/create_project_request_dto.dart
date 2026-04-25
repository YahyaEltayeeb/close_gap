class CreateProjectRequestDto {
  final String title;
  final String description;
  final String githubUrl;
  final String demoUrl;
  final List<String> skills;

  const CreateProjectRequestDto({
    required this.title,
    required this.description,
    required this.githubUrl,
    required this.demoUrl,
    required this.skills,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'github_url': githubUrl,
      'demo_url': demoUrl,
      'skills': skills,
    };
  }
}
