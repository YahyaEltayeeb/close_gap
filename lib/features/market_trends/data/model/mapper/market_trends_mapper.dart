import 'package:close_gap/features/market_trends/data/model/response/market_trend_dto.dart';
import 'package:close_gap/features/market_trends/data/model/response/market_trends_response_dto.dart';
import 'package:close_gap/features/market_trends/domain/entities/market_trend_item.dart';
import 'package:close_gap/features/market_trends/domain/entities/market_trends_result_entity.dart';

extension MarketTrendDtoMapper on MarketTrendDto {
  MarketTrendItem toEntity() {
    return MarketTrendItem(
      id: id,
      trackId: trackId,
      skillName: skillName,
      description: description,
      demandScore: demandScore,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime(2000),
    );
  }
}

extension MarketTrendsResponseDtoMapper on MarketTrendsResponseDto {
  MarketTrendsResultEntity toEntity() {
    return MarketTrendsResultEntity(
      count: count,
      trackId: trackId,
      trends: trends.map((item) => item.toEntity()).toList(),
    );
  }
}
