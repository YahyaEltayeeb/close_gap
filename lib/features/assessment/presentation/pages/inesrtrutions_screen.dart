import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/features/assessment/presentation/widgets/bullet_item.dart';
import 'package:close_gap/features/assessment/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  final int trackId;
  const InstructionsScreen({super.key, required this.trackId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back, size: 24, color: Colors.black),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Assessment',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black.withOpacity(0.88),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Welcome! Are you ready to take the test and\ndetermine your level? Please read the instructions\ncarefully before you begin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      child: Column(
                        children: const [
                          InfoRow(
                            icon: Icons.access_time_rounded,
                            title: 'Estimated Time',
                            subtitle:
                                'Plan for about 20 minutes to complete the assessment',
                          ),
                          SizedBox(height: 20),
                          InfoRow(
                            icon: Icons.help_outline_rounded,
                            title: 'Number of questions',
                            subtitle:
                                'There are 20 multiple-choice questions in total',
                          ),
                          SizedBox(height: 20),
                          InfoRow(
                            icon: Icons.description_outlined,
                            title: 'Question format',
                            subtitle:
                                'All questions are in a multiple-choice format',
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFEAECF0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instructions & Rules',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const BulletItem(
                            'Answer honestly based on your true preferences and abilities.',
                          ),
                          const BulletItem(
                            'In case of any attempt to cheat, the grades will not be counted.',
                          ),
                          const BulletItem(
                            'Please refrain from using any external resources or assistance.',
                          ),
                          const BulletItem(
                            'Your results will be available immediately upon completion.',
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC5EFFF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Color(0xFFF5A623),
                                  size: 22,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Important',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'This exam is monitored automatically. Any detected cheating may result in your session being canceled and disciplinary action being taken. If you encounter a technical problem, report it to support immediately.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1.5,
                                          color: Color(0xFF4A5568),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFEAECF0)),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.permissionpage, arguments:trackId);

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0084FF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
