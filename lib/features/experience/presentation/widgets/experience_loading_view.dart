import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExperienceLoadingView extends StatelessWidget {
  const ExperienceLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      children: const [
        _ShimmerLine(widthFactor: 0.45, height: 18),
        SizedBox(height: 10),
        _ShimmerLine(widthFactor: 0.88, height: 14),
        SizedBox(height: 22),
        _ExperienceCardSkeleton(),
        SizedBox(height: 12),
        _ExperienceCardSkeleton(),
      ],
    );
  }
}

class _ExperienceCardSkeleton extends StatelessWidget {
  const _ExperienceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8EDF3),
      highlightColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
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
                      _ShimmerLine(widthFactor: 0.52, height: 14),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                _ShimmerBox(width: 24, height: 24),
                SizedBox(width: 8),
                _ShimmerBox(width: 24, height: 24),
              ],
            ),
            SizedBox(height: 14),
            _ShimmerLine(widthFactor: 0.42, height: 14),
            SizedBox(height: 12),
            _ShimmerLine(widthFactor: 0.95, height: 14),
            SizedBox(height: 8),
            _ShimmerLine(widthFactor: 0.72, height: 14),
            SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ShimmerBox(width: 70, height: 30),
                _ShimmerBox(width: 88, height: 30),
                _ShimmerBox(width: 92, height: 30),
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
