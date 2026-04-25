import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/certificates/presentation/manager/certificates_cubit.dart';
import 'package:close_gap/features/certificates/presentation/widgets/selection_bottom_sheet.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCertificateSheet extends StatefulWidget {
  const AddCertificateSheet({
    super.key,
    required this.skills,
    required this.courses,
  });

  final List<SkillEntity> skills;
  final List<CourseOptionEntity> courses;

  @override
  State<AddCertificateSheet> createState() => _AddCertificateSheetState();
}

class _AddCertificateSheetState extends State<AddCertificateSheet> {
  final _titleController = TextEditingController();
  SkillEntity? _selectedSkill;
  CourseOptionEntity? _selectedCourse;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CertificatesCubit>().state;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Add Certificate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                'Backend fields: title, skill_id, course_id.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 18),
              _TextFieldBox(
                controller: _titleController,
                label: 'title',
                hint: 'ML Specialization',
              ),
              const SizedBox(height: 14),
              _SelectionField(
                label: 'skill_id',
                value: _selectedSkill?.name,
                hint: 'Select skill',
                onTap: _pickSkill,
              ),
              const SizedBox(height: 14),
              _SelectionField(
                label: 'course_id',
                value: _selectedCourse == null
                    ? null
                    : _courseLabel(_selectedCourse!),
                hint: 'Select course',
                onTap: _pickCourse,
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isSubmitting ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Submit Certificate',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickSkill() async {
    final result = await showModalBottomSheet<SkillEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectionBottomSheet<SkillEntity>(
        title: 'Select Skill',
        items: widget.skills,
        labelBuilder: (item) => item.name,
        searchHint: 'Search skills',
      ),
    );

    if (result != null && mounted) {
      setState(() => _selectedSkill = result);
    }
  }

  Future<void> _pickCourse() async {
    final result = await showModalBottomSheet<CourseOptionEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectionBottomSheet<CourseOptionEntity>(
        title: 'Select Course',
        items: widget.courses,
        labelBuilder: _courseLabel,
        searchHint: 'Search courses',
      ),
    );

    if (result != null && mounted) {
      setState(() => _selectedCourse = result);
    }
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final skill = _selectedSkill;
    final course = _selectedCourse;
    final cubit = context.read<CertificatesCubit>();

    if (title.isEmpty || skill == null || course == null) {
      ToastMessage.toastMsg(
        'Please complete title, skill, and course',
        backgroundColor: AppColors.red,
      );
      return;
    }

    final created = await cubit.createCertificate(
      CertificateRequestEntity(
        title: title,
        skillId: skill.id,
        courseId: course.id,
      ),
    );

    if (created && mounted) {
      Navigator.of(context).pop();
    }
  }

  String _courseLabel(CourseOptionEntity course) {
    final code = course.code?.isNotEmpty == true ? ' (${course.code})' : '';
    return '${course.name}$code';
  }
}

class _TextFieldBox extends StatelessWidget {
  const _TextFieldBox({
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({
    required this.label,
    required this.value,
    required this.hint,
    required this.onTap,
  });

  final String label;
  final String? value;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      color: value == null
                          ? Colors.grey.shade600
                          : Colors.black87,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
