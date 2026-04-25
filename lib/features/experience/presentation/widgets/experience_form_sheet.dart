import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/presentation/models/experience_form_result.dart';
import 'package:close_gap/features/experience/presentation/widgets/date_field.dart';
import 'package:close_gap/features/experience/presentation/widgets/experience_input_field.dart';
import 'package:flutter/material.dart';

class ExperienceFormSheet extends StatefulWidget {
  const ExperienceFormSheet({super.key, this.item});

  final ExperienceItem? item;

  @override
  State<ExperienceFormSheet> createState() => _ExperienceFormSheetState();
}

class _ExperienceFormSheetState extends State<ExperienceFormSheet> {
  late final TextEditingController _companyController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _skillsController;

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentRole = false;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _companyController = TextEditingController(text: item?.companyName ?? '');
    _titleController = TextEditingController(text: item?.title ?? '');
    _descriptionController = TextEditingController(
      text: item?.description ?? '',
    );
    _skillsController = TextEditingController(
      text: item?.skills.join(', ') ?? '',
    );
    _startDate = item?.startDate;
    _endDate = item?.endDate;
    _isCurrentRole = item?.endDate == null && item != null;
  }

  @override
  void dispose() {
    _companyController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    final maxSheetHeight = MediaQuery.of(context).size.height * 0.82;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                isEditing ? 'Edit Experience' : 'Add Experience',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Use the same field names expected by POST /experience/.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              ExperienceInputField(
                controller: _companyController,
                label: 'company_name',
                hint: 'Google',
              ),
              const SizedBox(height: 14),
              ExperienceInputField(
                controller: _titleController,
                label: 'title',
                hint: 'Backend Engineer',
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DateField(
                      label: 'start_date',
                      value: _startDate,
                      onTap: () => _pickDate(isStartDate: true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateField(
                      label: 'end_date',
                      value: _isCurrentRole ? null : _endDate,
                      hint: _isCurrentRole ? 'null' : 'Select date',
                      onTap: _isCurrentRole
                          ? null
                          : () => _pickDate(isStartDate: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _isCurrentRole,
                activeThumbColor: AppColors.lightPrimary,
                title: const Text(
                  'Current role',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'If enabled, end_date will be sent as null.',
                ),
                onChanged: (value) {
                  setState(() {
                    _isCurrentRole = value;
                    if (value) _endDate = null;
                  });
                },
              ),
              const SizedBox(height: 14),
              ExperienceInputField(
                controller: _descriptionController,
                label: 'description',
                hint: 'Built and maintained REST APIs...',
                maxLines: 4,
              ),
              const SizedBox(height: 14),
              ExperienceInputField(
                controller: _skillsController,
                label: 'skills',
                hint: 'python, django, postgresql',
              ),
              const SizedBox(height: 8),
              Text(
                'Enter skills as comma-separated values to match the backend list.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Update Experience' : 'Submit Experience',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
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

  Future<void> _pickDate({required bool isStartDate}) async {
    final initialDate = (isStartDate ? _startDate : _endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked == null || !mounted) return;

    setState(() {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  void _submit() {
    final companyName = _companyController.text.trim();
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final skills = _skillsController.text
        .split(',')
        .map((skill) => skill.trim().toLowerCase())
        .where((skill) => skill.isNotEmpty)
        .toList();

    if (companyName.isEmpty ||
        title.isEmpty ||
        description.isEmpty ||
        _startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the required fields')),
      );
      return;
    }

    Navigator.of(context).pop(
      ExperienceFormResult(
        companyName: companyName,
        title: title,
        startDate: _startDate!,
        endDate: _isCurrentRole ? null : _endDate,
        description: description,
        skills: skills,
      ),
    );
  }
}
