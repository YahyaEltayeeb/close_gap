import 'package:camera/camera.dart';
import 'package:close_gap/features/assessment/presentation/manager/exam/exam_cubit.dart';
import 'package:close_gap/features/assessment/presentation/widgets/instructions_card.dart';
import 'package:close_gap/features/assessment/presentation/widgets/question_card.dart';
import 'package:close_gap/features/assessment/presentation/widgets/question_navigator.dart';
import 'package:close_gap/features/assessment/presentation/widgets/top_bar.dart';
import 'package:close_gap/features/assessment/presentation/widgets/track_header.dart';
import 'package:close_gap/features/assessment/presentation/widgets/vision_status.dart';
import 'package:close_gap/features/exam_monitoring/presentation/manager/vision_check_cubit.dart';
import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class ExamScreen extends StatefulWidget {
  final CameraController controller;
  final int examId;

  const ExamScreen({
    super.key,
    required this.controller,
    required this.examId,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late VisionCheckCubit _visionCheckCubit;
  bool _isNavigating = false; // ✅ منع double navigation

  @override
  void initState() {
    super.initState();
    _visionCheckCubit = getIt<VisionCheckCubit>();
    _visionCheckCubit.startMonitoring(
      examId: widget.examId,
      captureImage: () async {
        // ✅ حماية الكاميرا
        if (!mounted) {
          throw Exception("Widget disposed");
        }
        if (!widget.controller.value.isInitialized) {
          throw Exception("Camera not ready");
        }
        final xfile = await widget.controller.takePicture();
        return File(xfile.path);
      },
    );
  }

  @override
  void dispose() {
    _visionCheckCubit.stopMonitoring();
    widget.controller.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _navigateToResult(Map<String, dynamic> args) {
    // ✅ منع navigation مرتين
    if (_isNavigating || !mounted) return;
    _isNavigating = true;
    _visionCheckCubit.stopMonitoring();
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.examResult,
      arguments: {...args, 'trackId': widget.examId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VisionCheckCubit, VisionCheckState>(
          bloc: _visionCheckCubit,
          listener: (context, visionState) {
            if (visionState is VisionCheckInvalidated) {
              context.read<ExamCubit>().forceFinishExam();
              _navigateToResult({'invalidated': true});
            }
          },
        ),
        BlocListener<ExamCubit, ExamState>(
          listener: (context, examState) {
            if (examState is ExamFinished) {
              _navigateToResult({
                'invalidated': false,
                'result': examState.result,
              });
            }
            if (examState is ExamInvalidated) {
              _navigateToResult({'invalidated': true});
            }
          },
        ),
      ],
      child: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, examState) {
          if (examState is ExamLoading) {
            return const Scaffold(
              backgroundColor: Color(0xFFF7F8FA),
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF2563EB)),
              ),
            );
          }

          if (examState is ExamError) {
            return Scaffold(
              backgroundColor: const Color(0xFFF7F8FA),
              body: Center(child: Text(examState.message)),
            );
          }

          if (examState is! ExamLoaded) {
            return const Scaffold(
              backgroundColor: Color(0xFFF7F8FA),
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF2563EB)),
              ),
            );
          }

          return BlocBuilder<VisionCheckCubit, VisionCheckState>(
            bloc: _visionCheckCubit,
            builder: (context, visionState) {
              final isCheating = visionState is VisionCheckWarning;
              final cameraColor = isCheating
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF22C55E);

              return Scaffold(
                backgroundColor: const Color(0xFFF7F8FA),
                body: SafeArea(
                  child: Column(
                    children: [
                      ExamTopBar(
                        remainingSeconds: examState.remainingSeconds,
                        formatTime: _formatTime,
                        onEndTest: () =>
                            context.read<ExamCubit>().finishExam(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              ExamTrackHeader(
                                controller: widget.controller,
                                cameraColor: cameraColor,
                              ),
                              const SizedBox(height: 16),
                              ExamQuestionCard(
                                examState: examState,
                                onAnswer: (qId, oId) => context
                                    .read<ExamCubit>()
                                    .selectAnswer(qId, oId),
                                onPrevious: () => context
                                    .read<ExamCubit>()
                                    .previousQuestion(),
                                onNext: () {
                                  final isLast =
                                      examState.currentIndex ==
                                          examState.questions.length - 1;
                                  if (isLast) {
                                    context.read<ExamCubit>().finishExam();
                                  } else {
                                    context.read<ExamCubit>().nextQuestion();
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              ExamQuestionNavigator(
                                total: examState.questions.length,
                                current: examState.currentIndex,
                                answers: examState.answers,
                                questions: examState.questions,
                                onTap: (i) {
                                  for (var j = examState.currentIndex;
                                      j < i;
                                      j++) {
                                    context
                                        .read<ExamCubit>()
                                        .nextQuestion();
                                  }
                                  for (var j = examState.currentIndex;
                                      j > i;
                                      j--) {
                                    context
                                        .read<ExamCubit>()
                                        .previousQuestion();
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              ExamVisionStatus(visionState: visionState),
                              const SizedBox(height: 16),
                              const ExamInstructionsCard(),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFBEB),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFFFDE68A)),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.warning_amber_rounded,
                                        color: Color(0xFFF59E0B),
                                        size: 18),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Please do not leave the full screen, any suspicious activity will be flagged',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF92400E)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
