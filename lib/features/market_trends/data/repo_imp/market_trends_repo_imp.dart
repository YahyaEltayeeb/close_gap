import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/market_trends/data/data_source/market_trends_ds.dart';
import 'package:close_gap/features/market_trends/data/model/mapper/market_trends_mapper.dart';
import 'package:close_gap/features/market_trends/domain/entities/market_trends_result_entity.dart';
import 'package:close_gap/features/market_trends/domain/repo/market_trends_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MarketTrendsRepo)
class MarketTrendsRepoImp implements MarketTrendsRepo {
  MarketTrendsRepoImp(this._marketTrendsDs);

  final MarketTrendsDs _marketTrendsDs;

  @override
  Future<ApiResult<MarketTrendsResultEntity>> getMarketTrends(int trackId) {
    return safeApiCall(() async {
      final result = await _marketTrendsDs.getMarketTrends(trackId);
      return result.toEntity();
    });
  }
}
