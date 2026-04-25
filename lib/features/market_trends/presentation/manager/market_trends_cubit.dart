import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/market_trends/domain/use_case/get_market_trends_use_case.dart';
import 'package:close_gap/features/market_trends/presentation/manager/market_trends_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarketTrendsCubit extends Cubit<MarketTrendsState> {
  MarketTrendsCubit(this._getMarketTrendsUseCase, this._tokenService)
    : super(const MarketTrendsState());

  final GetMarketTrendsUseCase _getMarketTrendsUseCase;
  final TokenService _tokenService;

  Future<void> loadTrends({int? trackId, String? trackName}) async {
    final savedTrackId = _tokenService.getSavedTrackId();
    final savedTrackName = _tokenService.getSavedTrackName();
    final resolvedTrackId = trackId ?? savedTrackId ?? 1;
    final resolvedTrackName =
        trackName ?? (resolvedTrackId == savedTrackId ? savedTrackName : null);

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getMarketTrendsUseCase(resolvedTrackId);
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isLoading: false,
            count: data.count,
            trackId: data.trackId,
            trackName: resolvedTrackName,
            trends: data.trends,
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(state.copyWith(isLoading: false, errorMessage: failure));
    }
  }
}
