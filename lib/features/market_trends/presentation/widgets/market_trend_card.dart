import 'package:close_gap/features/market_trends/domain/entities/market_trend_item.dart';
import 'package:close_gap/features/market_trends/presentation/helpers/market_trends_date_formatter.dart';
import 'package:flutter/material.dart';

class MarketTrendCard extends StatelessWidget {
  const MarketTrendCard({super.key, required this.trend});

  final MarketTrendItem trend;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  trend.skillName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _DemandBadge(score: trend.demandScore),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            trend.description,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _MetaChip(label: 'Track ${trend.trackId}'),
              const SizedBox(width: 8),
              _MetaChip(label: formatMarketTrendsDate(trend.createdAt)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DemandBadge extends StatelessWidget {
  const _DemandBadge({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Text(
            'Demand',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A66C2),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            score.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0A66C2),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
