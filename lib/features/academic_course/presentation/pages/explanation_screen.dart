import 'package:close_gap/features/academic_course/presentation/manager/academic_course_cubit.dart';
import 'package:close_gap/features/academic_course/presentation/manager/academic_course_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';


class ExplanationsScreen extends StatelessWidget {
  final String courseName;

  const ExplanationsScreen({super.key, required this.courseName});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      _showError(context, 'Invalid URL');
      return;
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError(context, 'Could not open the link');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF1A1A2E)),
        title: Text(
          '$courseName - Explanations',
          style: const TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AcademicCourseCubit, AcademicCourseStates>(
        buildWhen: (prev, curr) =>
            curr is AcademicCourseExplanationsLoading ||
            curr is AcademicCourseExplanationsSuccess ||
            curr is AcademicCourseExplanationsFailure,
        builder: (context, state) {
          if (state is AcademicCourseExplanationsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2196F3)),
            );
          }

          if (state is AcademicCourseExplanationsFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          }

          if (state is AcademicCourseExplanationsSuccess) {
            final explanations = state.explanations;
            if (explanations.isEmpty) {
              return const Center(child: Text('No explanations found.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: explanations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final exp = explanations[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.play_circle_outline,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    title: Text(
                      exp.title ?? 'No Title',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (exp.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            exp.description!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: exp.isFree == true
                                    ? const Color(0xFFE8F5E9)
                                    : const Color(0xFFFFF3E0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                exp.isFree == true ? 'Free' : 'Premium',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: exp.isFree == true
                                      ? const Color(0xFF388E3C)
                                      : const Color(0xFFF57C00),
                                ),
                              ),
                            ),
                            if (exp.qualityScore != null) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.star,
                                  size: 13, color: Color(0xFFFFC107)),
                              const SizedBox(width: 2),
                              Text(
                                exp.qualityScore!.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    trailing: exp.url != null
                        ? const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Color(0xFF2196F3))
                        : null,
                    onTap: exp.url != null
                        ? () => _openUrl(context, exp.url!)
                        : null,
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}