import 'package:json_annotation/json_annotation.dart';

part 'details_analysis_dto.g.dart';

@JsonSerializable()
class DetailsdAnalysisDto {
  final String formatting;
  final String content;
  final String keywords;
  final String structure;

  @JsonKey(name: 'missing_sections')
  final List<String> missingSections;

  @JsonKey(name: 'strong_keywords_found')
  final List<String> strongKeywordsFound;

  @JsonKey(name: 'suggested_keywords')
  final List<String> suggestedKeywords;

  @JsonKey(name: 'achievement_quality')
  final String achievementQuality;

  @JsonKey(name: 'ats_compatibility')
  final String atsCompatibility;

  DetailsdAnalysisDto({
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

  factory DetailsdAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$DetailsdAnalysisDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsdAnalysisDtoToJson(this);
}