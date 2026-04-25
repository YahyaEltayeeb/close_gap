import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MarketTrendsLoadingView extends StatelessWidget {
  const MarketTrendsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: const [
        _ShimmerLine(widthFactor: 0.4, height: 22),
        SizedBox(height: 10),
        _ShimmerLine(widthFactor: 0.78, height: 14),
        SizedBox(height: 22),
        _TrendCardSkeleton(),
        SizedBox(height: 12),
        _TrendCardSkeleton(),
      ],
    );
  }
}

class _TrendCardSkeleton extends StatelessWidget {
  const _TrendCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8EDF3),
      highlightColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShimmerBox(width: double.infinity, height: 20),
                      SizedBox(height: 8),
                      _ShimmerLine(widthFactor: 0.7, height: 20),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                _ShimmerBox(width: 62, height: 62),
              ],
            ),
            SizedBox(height: 14),
            _ShimmerLine(widthFactor: 0.95, height: 14),
            SizedBox(height: 8),
            _ShimmerLine(widthFactor: 0.9, height: 14),
            SizedBox(height: 8),
            _ShimmerLine(widthFactor: 0.62, height: 14),
            SizedBox(height: 14),
            Row(
              children: [
                _ShimmerBox(width: 74, height: 30),
                SizedBox(width: 8),
                _ShimmerBox(width: 98, height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({required this.widthFactor, required this.height});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: _ShimmerBox(width: double.infinity, height: height),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
