class AdvancedLearningPlanEntity {
  final bool ok;
  final int trackId;
  final List<RoadmapWeekEntity> roadmap;

  const AdvancedLearningPlanEntity({
    required this.ok,
    required this.trackId,
    required this.roadmap,
  });
}

class RoadmapWeekEntity {
  final int week;
  final String phase;
  final int hours;
  final List<String> skills;
  final List<String> kpis;
  final List<RoadmapCourseEntity> courses;

  const RoadmapWeekEntity({
    required this.week,
    required this.phase,
    required this.hours,
    required this.skills,
    required this.kpis,
    required this.courses,
  });
}

class RoadmapCourseEntity {
  final int id;
  final String title;
  final String level;
  final String type;
  final String url;
  final String? freeLink;
  final String? paidLink;
  final double weight;

  const RoadmapCourseEntity({
    required this.id,
    required this.title,
    required this.level,
    required this.type,
    required this.url,
    required this.freeLink,
    required this.paidLink,
    required this.weight,
  });
}
