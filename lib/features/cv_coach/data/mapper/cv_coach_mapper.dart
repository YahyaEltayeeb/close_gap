import 'package:close_gap/features/cv_coach/data/models/response/analysis_model_dto.dart';
import 'package:close_gap/features/cv_coach/data/models/response/cv_analysis_response_dto.dart';
import 'package:close_gap/features/cv_coach/data/models/response/details_analysis_dto.dart';
import 'package:close_gap/features/cv_coach/domain/entities/analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/entities/details_analysis_entity.dart';

extension DetailedAnalysisMapper on DetailsdAnalysisDto {
  DetailedAnalysisEntity toEntity() {
    return DetailedAnalysisEntity(
      formatting: formatting,
      content: content,
      keywords: keywords,
      structure: structure,
      missingSections: missingSections,
      strongKeywordsFound: strongKeywordsFound,
      suggestedKeywords: suggestedKeywords,
      achievementQuality: achievementQuality,
      atsCompatibility: atsCompatibility,
    );
  }
}

extension AnalysisMapper on AnalysisModelDto {
  AnalysisEntity toEntity() {
    return AnalysisEntity(
      overallScore: overallScore,
      formattingScore: formattingScore,
      contentScore: contentScore,
      keywordsScore: keywordsScore,
      structureScore: structureScore,
      strengths: strengths,
      weaknesses: weaknesses,
      recommendations: recommendations,
      detailedAnalysis: detailsAnalysis.toEntity(),
    );
  }
}

extension CvAnalysisResponseMapper on CvAnalysisResponseDto {
  CvAnalysisEntity toEntity() {
    return CvAnalysisEntity(
      message: message,
      filename: filename,
      analysis: analysis.toEntity(),
    );
  }
}
