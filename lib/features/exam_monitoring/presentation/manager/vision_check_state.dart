part of 'vision_check_cubit.dart';

abstract class VisionCheckState {
  const VisionCheckState();
}

class VisionCheckInitial extends VisionCheckState {}
class VisionCheckRunning extends VisionCheckState {}
class VisionCheckMonitoring extends VisionCheckState {}
class VisionCheckSafe extends VisionCheckState {}
class VisionCheckWarning extends VisionCheckState {
  final int strikes;

  const VisionCheckWarning(this.strikes);
}

class VisionCheckCheating extends VisionCheckState {
  final int strikes;
  final String reason;

  const VisionCheckCheating({
    required this.strikes,
    required this.reason,
  });
}

class VisionCheckInvalidated extends VisionCheckState {}

class VisionCheckError extends VisionCheckState {
  final String message;

  const VisionCheckError(this.message);
}