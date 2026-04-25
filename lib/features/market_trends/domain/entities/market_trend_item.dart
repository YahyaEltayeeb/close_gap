class MarketTrendItem {
  const MarketTrendItem({
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
  final DateTime createdAt;
}
