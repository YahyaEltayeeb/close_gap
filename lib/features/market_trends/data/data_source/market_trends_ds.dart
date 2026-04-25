import 'package:close_gap/features/market_trends/data/model/response/market_trends_response_dto.dart';

abstract class MarketTrendsDs {
  Future<MarketTrendsResponseDto> getMarketTrends(int trackId);
}
