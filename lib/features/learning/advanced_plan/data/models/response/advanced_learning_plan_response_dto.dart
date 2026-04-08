class AdvancedLearningPlanResponseDto {
  final bool ok;
  final int trackId;
  final List<RoadmapWeekDto> roadmap;

  const AdvancedLearningPlanResponseDto({
    required this.ok,
    required this.trackId,
    required this.roadmap,
  });

  factory AdvancedLearningPlanResponseDto.fromJson(Map<String, dynamic> json) {
    return AdvancedLearningPlanResponseDto(
      ok: json['ok'] as bool? ?? false,
      trackId: json['track_id'] as int? ?? 0,
      roadmap: (json['roadmap'] as List<dynamic>? ?? const [])
          .map((item) => RoadmapWeekDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RoadmapWeekDto {
  final int week;
  final String phase;
  final int hours;
  final List<String> skills;
  final List<String> kpis;
  final List<RoadmapCourseDto> courses;

  const RoadmapWeekDto({
    required this.week,
    required this.phase,
    required this.hours,
    required this.skills,
    required this.kpis,
    required this.courses,
  });

  factory RoadmapWeekDto.fromJson(Map<String, dynamic> json) {
    return RoadmapWeekDto(
      week: json['week'] as int? ?? 0,
      phase: json['phase'] as String? ?? '',
      hours: json['hours'] as int? ?? 0,
      skills: (json['skills'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      kpis: (json['kpis'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      courses: (json['courses'] as List<dynamic>? ?? const [])
          .map((item) => RoadmapCourseDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RoadmapCourseDto {
  final int id;
  final String title;
  final String level;
  final String type;
  final String url;
  final String? freeLink;
  final String? paidLink;
  final double weight;

  const RoadmapCourseDto({
    required this.id,
    required this.title,
    required this.level,
    required this.type,
    required this.url,
    required this.freeLink,
    required this.paidLink,
    required this.weight,
  });

  factory RoadmapCourseDto.fromJson(Map<String, dynamic> json) {
    return RoadmapCourseDto(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      level: json['level'] as String? ?? '',
      type: json['type'] as String? ?? '',
      url: json['url'] as String? ?? '',
      freeLink: json['free_link'] as String?,
      paidLink: json['paid_link'] as String?,
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
    );
  }
}
