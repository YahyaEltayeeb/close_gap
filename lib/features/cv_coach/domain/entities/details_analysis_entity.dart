class DetailedAnalysisEntity {
  final String formatting;
  final String content;
  final String keywords;
  final String structure;

  final List<String> missingSections;
  final List<String> strongKeywordsFound;
  final List<String> suggestedKeywords;

  final String achievementQuality;
  final String atsCompatibility;

  DetailedAnalysisEntity({
    required this.formatting,
    required this.content,
    required this.keywords,
    required this.structure,
    required this.missingSections,
    required this.strongKeywordsFound,
    required this.suggestedKeywords,
    required this.achievementQuality,
    required this.atsCompatibility,
  });
}