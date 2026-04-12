import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/features/assessment/presentation/manager/permission/exam_permission_State.dart';
import 'package:close_gap/features/assessment/presentation/manager/permission/exam_permission_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/camera_box.dart';
import '../widgets/permission_button.dart';
import '../widgets/warning_widget.dart';

class ExamPermissionScreen extends StatelessWidget {
  final int trackId;
  const ExamPermissionScreen({super.key, required this.trackId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExamPermissionCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<ExamPermissionCubit, ExamPermissionState>(
            listener: (context, state) {
              /// ❌ لو المستخدم رفض الإذن
              if (state is ExamPermissionDenied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Camera permission denied")),
                );
              }

              /// ❌ لو رفض نهائي
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
                        onPressed: () {
                          openAppSettings();
                        },
                        child: const Text("Open Settings"),
                      ),
                    ],
                  ),
                );
              }

              /// ⚠️ Error
              if (state is ExamPermissionError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            /// 👇 ده الـ UI كله
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

                  const Text(
                    "Allow Camera, Mic, Screen Access",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

                  /// UI reactive
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

                              /// 👈 هنا التعديل
                            ),

                            const SizedBox(height: 20),

                            PermissionButton(
                              enabled: cubit.isCameraOn,
                              onPressed: () {
                                if (cubit.isCameraOn) {
                                  final controller = cubit.controller!;

                                  // ✅ امنع الـ cubit من يعمل dispose للكاميرا
                                  cubit.controller = null;
                                  context.pushNamed(
                                    AppRoutes.examScreen,
                                    arguments: {
                                      'controller': controller,
                                      'trackId': trackId,
                                    },
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
