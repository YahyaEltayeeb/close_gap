import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/market_trends/domain/entities/market_trends_result_entity.dart';
import 'package:close_gap/features/market_trends/domain/repo/market_trends_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMarketTrendsUseCase {
  GetMarketTrendsUseCase(this._marketTrendsRepo);

  final MarketTrendsRepo _marketTrendsRepo;

  Future<ApiResult<MarketTrendsResultEntity>> call(int trackId) {
    return _marketTrendsRepo.getMarketTrends(trackId);
  }
}
