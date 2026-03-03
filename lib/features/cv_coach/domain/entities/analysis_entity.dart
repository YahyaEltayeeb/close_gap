import 'package:close_gap/features/cv_coach/domain/entities/details_analysis_entity.dart';

class AnalysisEntity {
  final int overallScore;
  final int formattingScore;
  final int contentScore;
  final int keywordsScore;
  final int structureScore;

  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> recommendations;

  final DetailedAnalysisEntity detailedAnalysis;

  AnalysisEntity({
    required this.overallScore,
    required this.formattingScore,
    required this.contentScore,
    required this.keywordsScore,
    required this.structureScore,
    required this.strengths,
    required this.weaknesses,
    required this.recommendations,
    required this.detailedAnalysis,
  });
}
