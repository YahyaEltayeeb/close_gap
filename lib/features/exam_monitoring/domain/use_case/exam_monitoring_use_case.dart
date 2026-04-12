import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';
import 'package:close_gap/features/exam_monitoring/domain/repo/exam_monitoring_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ExamMonitoringUseCase {
  final ExamMonitoringRepo _examMonitoringRepo;

  ExamMonitoringUseCase(this._examMonitoringRepo);

  Future<ApiResult<VisionCheckCameraEntity>> call(
    VisionCheckCameraRequest visionCheckCameraRequest,
  ) {
    return _examMonitoringRepo.visionCheck(visionCheckCameraRequest);
  }
}