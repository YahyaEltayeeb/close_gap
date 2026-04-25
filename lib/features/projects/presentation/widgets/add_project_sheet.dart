import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:close_gap/features/projects/presentation/manager/projects_cubit.dart';
import 'package:close_gap/features/projects/presentation/widgets/project_input_field.dart';
import 'package:close_gap/features/projects/presentation/widgets/skills_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProjectSheet extends StatefulWidget {
  const AddProjectSheet({super.key, required this.skills});

  final List<SkillEntity> skills;

  @override
  State<AddProjectSheet> createState() => _AddProjectSheetState();
}

class _AddProjectSheetState extends State<AddProjectSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _githubController = TextEditingController();
  final _demoController = TextEditingController();
  final Set<String> _selectedSkills = {};

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _githubController.dispose();
    _demoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProjectsCubit>().state;

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
                'Add New Project',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                'Keep only the fields supported by the API response.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 18),
              ProjectInputField(
                controller: _titleController,
                label: 'Project title',
                hint: 'Enter project title',
              ),
              const SizedBox(height: 14),
              ProjectInputField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Describe what the project does',
                maxLines: 4,
              ),
              const SizedBox(height: 14),
              ProjectInputField(
                controller: _githubController,
                label: 'GitHub URL',
                hint: 'https://github.com/...',
              ),
              const SizedBox(height: 14),
              ProjectInputField(
                controller: _demoController,
                label: 'Demo URL',
                hint: 'https://...',
              ),
              const SizedBox(height: 18),
              const Text(
                'Skills',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _showSkillsPicker,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedSkills.isEmpty
                              ? 'Select skills'
                              : '${_selectedSkills.length} skill(s) selected',
                          style: TextStyle(
                            color: _selectedSkills.isEmpty
                                ? Colors.grey.shade600
                                : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              ),
              if (_selectedSkills.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedSkills
                      .map(
                        (skill) => InputChip(
                          label: Text(skill),
                          selected: true,
                          onDeleted: () => setState(() {
                            _selectedSkills.remove(skill);
                          }),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (_selectedSkills.isEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  'Pick one or more skills from the dropdown.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
              const SizedBox(height: 20),
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
                          'Submit Project',
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

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final githubUrl = _githubController.text.trim();
    final demoUrl = _demoController.text.trim();
    final cubit = context.read<ProjectsCubit>();

    if (title.isEmpty ||
        description.isEmpty ||
        githubUrl.isEmpty ||
        demoUrl.isEmpty ||
        _selectedSkills.isEmpty) {
      ToastMessage.toastMsg(
        'Please complete all fields and select at least one skill',
        backgroundColor: AppColors.red,
      );
      return;
    }

    final created = await cubit.createProject(
      title: title,
      description: description,
      githubUrl: githubUrl,
      demoUrl: demoUrl,
      skills: _selectedSkills.toList(),
    );

    if (created && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _showSkillsPicker() async {
    final selected = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SkillsPickerSheet(
        skills: widget.skills,
        initialSelectedSkills: _selectedSkills,
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _selectedSkills
          ..clear()
          ..addAll(selected);
      });
    }
  }
}
