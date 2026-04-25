import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/market_trends/presentation/manager/market_trends_cubit.dart';
import 'package:close_gap/features/market_trends/presentation/manager/market_trends_state.dart';
import 'package:close_gap/features/market_trends/presentation/widgets/empty_market_trends_card.dart';
import 'package:close_gap/features/market_trends/presentation/widgets/market_trend_card.dart';
import 'package:close_gap/features/market_trends/presentation/widgets/market_trends_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketTrendsScreen extends StatelessWidget {
  const MarketTrendsScreen({super.key, this.trackId, this.trackName});

  final int? trackId;
  final String? trackName;

  @override
  Widget build(BuildContext context) {
    final tokenService = getIt<TokenService>();
    final savedTrackId = tokenService.getSavedTrackId();
    final resolvedTrackId = trackId ?? savedTrackId ?? 1;
    final resolvedTrackName =
        trackName ??
        (resolvedTrackId == savedTrackId
            ? tokenService.getSavedTrackName()
            : null);

    return BlocProvider(
      create: (_) => getIt<MarketTrendsCubit>()
        ..loadTrends(trackId: resolvedTrackId, trackName: resolvedTrackName),
      child: const _MarketTrendsView(),
    );
  }
}

class _MarketTrendsView extends StatelessWidget {
  const _MarketTrendsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketTrendsCubit, MarketTrendsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6F8FB),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: const Text(
              'Market Trends',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<MarketTrendsCubit>().loadTrends(
              trackId: state.trackId,
            ),
            child: state.isLoading
                ? const MarketTrendsLoadingView()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                        children: [
                          _MarketTrendsSummary(
                            count: state.count,
                            trackId: state.trackId,
                            trackName: state.trackName,
                          ),
                          const SizedBox(height: 18),
                          if (state.trends.isEmpty)
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - 180,
                              ),
                              child: const Center(
                                child: EmptyMarketTrendsCard(),
                              ),
                            )
                          else
                            ...state.trends.map(
                              (trend) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: MarketTrendCard(trend: trend),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _MarketTrendsSummary extends StatelessWidget {
  const _MarketTrendsSummary({
    required this.count,
    required this.trackId,
    this.trackName,
  });

  final int count;
  final int trackId;
  final String? trackName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Market Trends',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Top in-demand skills and emerging topics for ${_resolvedTrackLabel()}.',
            style: TextStyle(color: Colors.grey.shade600, height: 1.45),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              '$count trends available',
              style: const TextStyle(
                color: Color(0xFF0A66C2),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolvedTrackLabel() {
    final normalizedTrackName = trackName?.trim() ?? '';
    if (normalizedTrackName.isNotEmpty) {
      return normalizedTrackName;
    }
    return 'track $trackId';
  }
}
