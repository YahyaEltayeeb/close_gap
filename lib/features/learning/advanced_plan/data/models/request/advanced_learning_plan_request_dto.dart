class AdvancedLearningPlanRequestDto {
  final int trackId;

  const AdvancedLearningPlanRequestDto({required this.trackId});

  Map<String, dynamic> toJson() => {'track_id': trackId};
}
