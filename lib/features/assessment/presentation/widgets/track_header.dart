import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ExamTrackHeader extends StatelessWidget {
  const ExamTrackHeader({
    super.key,
    required this.controller,
    required this.cameraColor,
    this.trackName,
  });

  final CameraController controller;
  final Color cameraColor;
  final String? trackName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _resolvedTrackName(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Complete the following assessment',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 110,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cameraColor, width: 2.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: controller.value.isInitialized
                ? CameraPreview(controller)
                : const SizedBox(),
          ),
        ),
      ],
    );
  }

  String _resolvedTrackName() {
    final normalizedTrackName = trackName?.trim() ?? '';
    if (normalizedTrackName.isNotEmpty) {
      return normalizedTrackName;
    }
    return 'Assessment Track';
  }
}
