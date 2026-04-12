import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraBox extends StatelessWidget {
  final bool isCameraOn;
  final CameraController? controller;
  final VoidCallback onCameraTap;

  const CameraBox({
    super.key,
    required this.isCameraOn,
    required this.controller,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Camera preview or placeholder
            if (isCameraOn && controller != null)
              Positioned.fill(
                child: CameraPreview(controller!),
              )
            else
              const Center(
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: Colors.grey,
                ),
              ),

            // Controls
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _icon(Icons.screen_share),
                  const SizedBox(width: 15),

                  GestureDetector(
                    onTap: onCameraTap,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor:
                          isCameraOn ? Colors.green : Colors.red,
                      child: Icon(
                        isCameraOn
                            ? Icons.videocam
                            : Icons.videocam_off,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),
                  _icon(Icons.mic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.grey),
    );
  }
}