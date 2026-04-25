class MarketTrendDto {
  const MarketTrendDto({
    required this.id,
    required this.trackId,
    required this.skillName,
    required this.description,
    required this.demandScore,
    required this.createdAt,
  });

  final int id;
  final int trackId;
  final String skillName;
  final String description;
  final double demandScore;
  final String createdAt;

  factory MarketTrendDto.fromJson(Map<String, dynamic> json) {
    return MarketTrendDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      trackId: (json['track_id'] as num?)?.toInt() ?? 0,
      skillName: json['skill_name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      demandScore: (json['demand_score'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
