import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraOverlayWidget extends StatelessWidget {
  final CameraController controller;

  const CameraOverlayWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox();
    }

    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CameraPreview(controller),
      ),
    );
  }
}