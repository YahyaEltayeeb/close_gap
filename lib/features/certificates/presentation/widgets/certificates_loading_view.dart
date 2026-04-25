import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CertificatesLoadingView extends StatelessWidget {
  const CertificatesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      children: const [
        _ShimmerLine(widthFactor: 0.42, height: 18),
        SizedBox(height: 12),
        _ShimmerLine(widthFactor: 0.78, height: 14),
        SizedBox(height: 22),
        _CertificateCardSkeleton(),
        SizedBox(height: 12),
        _CertificateCardSkeleton(),
      ],
    );
  }
}

class _CertificateCardSkeleton extends StatelessWidget {
  const _CertificateCardSkeleton();

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
            _ShimmerBox(width: double.infinity, height: 20),
            SizedBox(height: 12),
            _ShimmerLine(widthFactor: 0.5, height: 14),
            SizedBox(height: 8),
            _ShimmerLine(widthFactor: 0.74, height: 14),
            SizedBox(height: 8),
            _ShimmerLine(widthFactor: 0.38, height: 14),
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
