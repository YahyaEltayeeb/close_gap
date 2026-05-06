import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/features/assessment/presentation/manager/exam/exam_cubit.dart';
import 'package:close_gap/features/assessment/presentation/manager/permission/exam_permission_State.dart';
import 'package:close_gap/features/assessment/presentation/manager/permission/exam_permission_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/camera_box.dart';
import '../widgets/permission_button.dart';
import '../widgets/warning_widget.dart';

class ExamPermissionScreen extends StatelessWidget {
  const ExamPermissionScreen({super.key, this.trackId, this.trackName});

  final int? trackId;
  final String? trackName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExamPermissionCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<ExamPermissionCubit, ExamPermissionState>(
            listener: (context, state) {
              if (state is ExamPermissionDenied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Camera permission denied")),
                );
              }

              if (state is ExamPermissionPermanentlyDenied) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Permission Required"),
                    content: const Text(
                      "Please enable camera permission from settings",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => openAppSettings(),
                        child: const Text("Open Settings"),
                      ),
                    ],
                  ),
                );
              }

              if (state is ExamPermissionError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: context.pop,
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    trackName?.trim().isNotEmpty == true
                        ? "Allow Camera, Mic, Screen Access for $trackName"
                        : "Allow Camera, Mic, Screen Access",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "To ensure exam security, we need access...",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  BlocBuilder<ExamPermissionCubit, ExamPermissionState>(
                    builder: (context, state) {
                      final cubit = context.read<ExamPermissionCubit>();

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CameraBox(
                              isCameraOn: cubit.isCameraOn,
                              controller: cubit.controller,
                              onCameraTap: () => cubit.handleCamera(),
                            ),
                            const SizedBox(height: 20),
                            PermissionButton(
                              enabled: cubit.isCameraOn && trackId != null,
                              onPressed: () async {
                                // ✅ FIX 1: خد الـ controller بدون !
                                final controller = cubit.controller;

                                // ✅ FIX 2: تحقق من null قبل أي حاجة
                                if (controller == null ||
                                    !cubit.isCameraOn ||
                                    trackId == null) {
                                  return;
                                }

                                // ✅ فاضي الـ controller من الـ cubit
                                cubit.controller = null;

                                // ✅ FIX 3: استلم نفس الـ ExamCubit instance
                                final examCubit = context.read<ExamCubit>();

                                // ✅ FIX 4: ابدأ الـ exam واستنى الـ future
                                await examCubit.startExam(trackId: trackId!);

                                // ✅ FIX 5: اقرأ الـ state مباشرة بعد ما startExam خلص
                                final examState = examCubit.state;

                                // ✅ FIX 6: تأكد إن الـ context لسه موجود
                                if (!context.mounted) return;

                                if (examState is ExamLoaded) {
                                  context.pushNamed(
                                    AppRoutes.examScreen,
                                    arguments: {
                                      'controller': controller,
                                      'trackId': trackId,
                                      'trackName': trackName,
                                      'examId': examState.examId,
                                      // ✅ FIX 7: ابعت نفس الـ instance
                                      'examCubit': examCubit,
                                    },
                                  );
                                } else if (examState is ExamError) {
                                  // ✅ رجّع الـ controller لو فشل
                                  cubit.controller = controller;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(examState.message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 10),
                            const WarningWidget(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}