import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/market_trends/domain/entities/market_trends_result_entity.dart';

abstract class MarketTrendsRepo {
  Future<ApiResult<MarketTrendsResultEntity>> getMarketTrends(int trackId);
}
