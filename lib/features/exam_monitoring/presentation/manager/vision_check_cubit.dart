import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/exam_monitoring/data/models/request/vision_check_camera_request.dart';
import 'package:close_gap/features/exam_monitoring/domain/entities/vision_check_camera_entity.dart';
import 'package:close_gap/features/exam_monitoring/domain/use_case/exam_monitoring_use_case.dart';

part 'vision_check_state.dart';

@Injectable()
class VisionCheckCubit extends Cubit<VisionCheckState> {
  final ExamMonitoringUseCase _useCase;

  VisionCheckCubit(this._useCase) : super(const VisionCheckInitial());

  Timer? _timer;

  int _examId = 0;
  bool _running = false;
  bool _isClosedManually = false;

  void startMonitoring({
    required int examId,
    required Future<File> Function() captureImage,
  }) {
    if (_running || isClosed || _timer != null) return;

    _examId = examId;
    _running = true;
    _isClosedManually = false;
    print("VISION CHECK EXAM ID: $_examId");
    emit(const VisionCheckRunning());

    _timer = Timer.periodic(const Duration(seconds: 20), (timer) async {
      if (!_canContinue) {
        timer.cancel();
        return;
      }

      try {
        final file = await captureImage();
        if (!_canContinue) return;

        final base64Image = base64Encode(await file.readAsBytes());
        if (!_canContinue) return;

        final result = await _useCase(
          VisionCheckCameraRequest(
            examId: _examId,
            image: base64Image,
          ),
        );

        if (!_canContinue) return;

        if (result is ApiSuccessResult<VisionCheckCameraEntity>) {
          _handleResult(result.data);
        } else if (result is ApiErrorResult<VisionCheckCameraEntity>) {
          emit(VisionCheckError(result.failure.toString()));
        }
      } catch (e) {
        if (!_canContinue) return;

        final error = e.toString();

        if (error.contains('HandshakeException') ||
            error.contains('Connection') ||
            error.contains('disposed') ||
            error.contains('not ready')) {
          return;
        }

        emit(const VisionCheckError("Camera error"));
      }
    });
  }

  bool get _canContinue {
    return !isClosed && !_isClosedManually && _running;
  }

  void _handleResult(VisionCheckCameraEntity entity) {
    if (!_canContinue) return;

    final int strikes = entity.strikes ?? 0;

    final String reason = _getReason(entity);

    if (entity.invalidated == true || strikes >= 3) {
      emit(
        VisionCheckInvalidated(
          strikes: strikes,
          reason: reason,
        ),
      );

      stopMonitoring(resetState: false);
      return;
    }

    if (strikes > 0) {
      emit(
        VisionCheckWarning(
          strikes: strikes,
          reason: reason,
        ),
      );
      return;
    }

    emit(const VisionCheckSafe());
  }

  String _getReason(VisionCheckCameraEntity entity) {
    final result = entity.result;

    if (result?.phoneDetected == true) {
      return "Phone detected";
    }

    if (result?.eyeContact == false) {
      return "Student is not looking at the screen";
    }

    return "Suspicious behavior detected";
  }

  void stopMonitoring({bool resetState = true}) {
    _isClosedManually = true;

    _timer?.cancel();
    _timer = null;
    _running = false;

    if (resetState && !isClosed) {
      emit(const VisionCheckInitial());
    }
  }

  @override
  Future<void> close() {
    _isClosedManually = true;
    _timer?.cancel();
    _timer = null;
    _running = false;

    return super.close();
  }
}