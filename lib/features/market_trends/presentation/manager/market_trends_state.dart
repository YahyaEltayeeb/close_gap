import 'package:close_gap/features/market_trends/domain/entities/market_trend_item.dart';

class MarketTrendsState {
  static const _sentinel = Object();

  const MarketTrendsState({
    this.isLoading = false,
    this.count = 0,
    this.trackId = 1,
    this.trackName,
    this.trends = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final int count;
  final int trackId;
  final String? trackName;
  final List<MarketTrendItem> trends;
  final String? errorMessage;

  MarketTrendsState copyWith({
    bool? isLoading,
    int? count,
    int? trackId,
    Object? trackName = _sentinel,
    List<MarketTrendItem>? trends,
    Object? errorMessage = _sentinel,
  }) {
    return MarketTrendsState(
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      trackId: trackId ?? this.trackId,
      trackName: identical(trackName, _sentinel)
          ? this.trackName
          : trackName as String?,
      trends: trends ?? this.trends,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
