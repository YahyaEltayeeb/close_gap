class CompareCvResultEntity {
  final int score;
  final List<String> matchedSkills;
  final List<String> unmatchedSkills;
  final bool experienceMatch;
  final bool educationMatch;
  final String analysis;
  final String? hrEmail;

  const CompareCvResultEntity({
    required this.score,
    required this.matchedSkills,
    required this.unmatchedSkills,
    required this.experienceMatch,
    required this.educationMatch,
    required this.analysis,
    this.hrEmail,
  });
}
