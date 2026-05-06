part of 'vision_check_cubit.dart';

abstract class VisionCheckState {
  const VisionCheckState();
}

class VisionCheckInitial extends VisionCheckState {
  const VisionCheckInitial();
}

class VisionCheckRunning extends VisionCheckState {
  const VisionCheckRunning();
}

// ✅ VisionCheckMonitoring اتحذف لأنها مش بتتستخدم

class VisionCheckSafe extends VisionCheckState {
  const VisionCheckSafe();
}

class VisionCheckWarning extends VisionCheckState {
  final int strikes;
  final String reason;

  const VisionCheckWarning({
    required this.strikes,
    required this.reason,
  });
}

class VisionCheckInvalidated extends VisionCheckState {
  final int strikes;
  final String reason;

  const VisionCheckInvalidated({
    required this.strikes,
    required this.reason,
  });
}

class VisionCheckError extends VisionCheckState {
  final String message;

  const VisionCheckError(this.message);
}