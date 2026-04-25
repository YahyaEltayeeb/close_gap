import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/features/market_trends/data/data_source/market_trends_ds.dart';
import 'package:close_gap/features/market_trends/data/model/response/market_trends_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MarketTrendsDs)
class MarketTrendsDsImp implements MarketTrendsDs {
  MarketTrendsDsImp(this._apiServices);

  final ApiServices _apiServices;

  @override
  Future<MarketTrendsResponseDto> getMarketTrends(int trackId) async {
    final response = await _apiServices.getMarketTrends(trackId);
    return MarketTrendsResponseDto.fromJson(response as Map<String, dynamic>);
  }
}
