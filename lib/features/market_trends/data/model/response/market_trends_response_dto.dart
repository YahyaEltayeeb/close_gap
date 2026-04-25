import 'package:close_gap/features/market_trends/data/model/response/market_trend_dto.dart';

class MarketTrendsResponseDto {
  const MarketTrendsResponseDto({
    required this.count,
    required this.trackId,
    required this.trends,
  });

  final int count;
  final int trackId;
  final List<MarketTrendDto> trends;

  factory MarketTrendsResponseDto.fromJson(Map<String, dynamic> json) {
    final rawTrends = json['trends'];
    return MarketTrendsResponseDto(
      count: (json['count'] as num?)?.toInt() ?? 0,
      trackId: (json['track_id'] as num?)?.toInt() ?? 0,
      trends: rawTrends is List
          ? rawTrends
                .map(
                  (item) =>
                      MarketTrendDto.fromJson(item as Map<String, dynamic>),
                )
                .toList()
          : const [],
    );
  }
}
