import 'package:camera/camera.dart';

abstract class ExamPermissionState {}

class ExamPermissionInitial extends ExamPermissionState {}

class ExamPermissionLoading extends ExamPermissionState {}

class ExamPermissionCameraOn extends ExamPermissionState {
  final CameraController controller;
  ExamPermissionCameraOn(this.controller);
}

class ExamPermissionDenied extends ExamPermissionState {}

class ExamPermissionPermanentlyDenied extends ExamPermissionState {}

class ExamPermissionError extends ExamPermissionState {
  final String message;

  ExamPermissionError(this.message);
}