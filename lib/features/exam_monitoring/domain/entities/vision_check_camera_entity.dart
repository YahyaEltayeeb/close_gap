class VisionCheckCameraEntity {
  final bool? invalidated;
  final bool? ok;
  final ResultEntity? result;
  final int? strikes;

  const VisionCheckCameraEntity({
    this.invalidated,
    this.ok,
    this.result,
    this.strikes,
  });
}

class ResultEntity {
  final bool? phoneDetected;
  final bool? eyeContact;

  const ResultEntity({
    this.phoneDetected,
    this.eyeContact,
  });
}