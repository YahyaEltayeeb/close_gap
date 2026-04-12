import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:close_gap/features/assessment/presentation/manager/permission/exam_permission_State.dart';
@Injectable()
class ExamPermissionCubit extends Cubit<ExamPermissionState> {
  ExamPermissionCubit() : super(ExamPermissionInitial());

  CameraController? controller;
CameraController? get cameraController => controller;

  /// Toggle camera (فتح / قفل)
  Future<void> handleCamera() async {
    // لو الكاميرا شغالة → اقفلها
    if (isCameraOn) {
      stopCamera();
      return;
    }

    // لو مش شغالة → اطلب permission و شغلها
    emit(ExamPermissionLoading());

    final status = await Permission.camera.request();

    if (status.isGranted) {
      await _startCamera();
    } else if (status.isPermanentlyDenied) {
      emit(ExamPermissionPermanentlyDenied());
    } else {
      emit(ExamPermissionDenied());
    }
  }

  /// تشغيل الكاميرا
  Future<void> _startCamera() async {
    try {
      final cameras = await availableCameras();

      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
      );

      controller = CameraController(
        front,
        ResolutionPreset.medium,
      );

      await controller!.initialize();

      emit(ExamPermissionCameraOn(controller!));
    } catch (e) {
      emit(ExamPermissionError(e.toString()));
    }
  }

  /// إيقاف الكاميرا
  void stopCamera() {
    controller?.dispose();
    controller = null;
    emit(ExamPermissionInitial());
  }

  /// حالة الكاميرا
  bool get isCameraOn => state is ExamPermissionCameraOn;

  @override
  Future<void> close() {
    return super.close();
  }
  Future<XFile?> takePicture() async {
  if (controller == null || !controller!.value.isInitialized) {
    return null;
  }

  try {
    final file = await controller!.takePicture();
    return file;
  } catch (e) {
    return null;
  }
}
}