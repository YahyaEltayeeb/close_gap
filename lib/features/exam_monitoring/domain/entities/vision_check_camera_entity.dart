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
   
  const ResultEntity({this.phoneDetected});
}