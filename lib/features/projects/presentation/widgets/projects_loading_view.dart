import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProjectsLoadingView extends StatelessWidget {
  const ProjectsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
      children: const [
        _ShimmerLine(widthFactor: 0.9, height: 18),
        SizedBox(height: 10),
        _ShimmerLine(widthFactor: 0.72, height: 18),
        SizedBox(height: 22),
        _ProjectCardSkeleton(),
        SizedBox(height: 14),
        _ProjectCardSkeleton(),
      ],
    );
  }
}

class _ProjectCardSkeleton extends StatelessWidget {
  const _ProjectCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8EDF3),
      highlightColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
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
                      _ShimmerBox(width: double.infinity, height: 22),
                      SizedBox(height: 10),
                      _ShimmerLine(widthFactor: 0.95, height: 14),
                      SizedBox(height: 8),
                      _ShimmerLine(widthFactor: 0.68, height: 14),
                    ],
                  ),
                ),
                SizedBox(width: 14),
                _ShimmerBox(width: 28, height: 28),
              ],
            ),
            SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ShimmerBox(width: 74, height: 32),
                _ShimmerBox(width: 88, height: 32),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _ShimmerBox(width: double.infinity, height: 48),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _ShimmerBox(width: double.infinity, height: 48),
                ),
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
