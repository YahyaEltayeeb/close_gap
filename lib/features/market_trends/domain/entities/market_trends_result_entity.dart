import 'package:close_gap/features/market_trends/domain/entities/market_trend_item.dart';

class MarketTrendsResultEntity {
  const MarketTrendsResultEntity({
    required this.count,
    required this.trackId,
    required this.trends,
  });

  final int count;
  final int trackId;
  final List<MarketTrendItem> trends;
}
