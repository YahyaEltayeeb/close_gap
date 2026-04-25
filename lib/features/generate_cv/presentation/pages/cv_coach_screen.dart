import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/generate_cv/domain/entities/generate_cv_request_entity.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_cubit.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_state.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/helper_function.dart';
import 'package:close_gap/features/generate_cv/presentation/pages/cv_ready_screen.dart';
import 'package:close_gap/features/generate_cv/presentation/pages/pdf_viewer_screen.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/cv_multi_select_sheet.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/cv_status_header.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/generate_cv_appbar.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/ready_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateCvScreen extends StatelessWidget {
  const GenerateCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GenerateCvCubit>()..loadLookups(),
      child: const _GenerateCvView(),
    );
  }
}

class _GenerateCvView extends StatefulWidget {
  const _GenerateCvView();

  @override
  State<_GenerateCvView> createState() => _GenerateCvViewState();
}

class _GenerateCvViewState extends State<_GenerateCvView> {
  static const _languageOptions = [
    'Arabic',
    'English',
    'French',
    'German',
    'Spanish',
    'Italian',
  ];
  static const _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _skillsController = TextEditingController();
  final _languagesController = TextEditingController();
  final List<_ExperienceFormItem> _experienceItems = [];
  final List<_EducationFormItem> _educationItems = [];
  final List<_CourseFormItem> _courseItems = [];

  @override
  void initState() {
    super.initState();
    _experienceItems.add(_ExperienceFormItem());
    _educationItems.add(_EducationFormItem());
    _courseItems.add(_CourseFormItem());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    _skillsController.dispose();
    _languagesController.dispose();
    for (final item in _experienceItems) {
      item.dispose();
    }
    for (final item in _educationItems) {
      item.dispose();
    }
    for (final item in _courseItems) {
      item.dispose();
    }
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<GenerateCvCubit>().generateCv(
      GenerateCvRequestEntity(
        name: _nameController.text.trim(),
        jobTitle: _jobTitleController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        linkedin: _linkedinController.text.trim(),
        github: _githubController.text.trim(),
        skills: _toList(_skillsController.text),
        experience: _experienceItems
            .map(
              (item) => CvExperienceEntryEntity(
                role: item.roleController.text.trim(),
                company: item.companyController.text.trim(),
                location: item.locationController.text.trim(),
                duration: _formatDuration(item.startDate, item.endDate),
                responsibilities: _toList(item.responsibilitiesController.text),
              ),
            )
            .toList(),
        education: _educationItems
            .map(
              (item) => CvEducationEntryEntity(
                degree: item.degreeController.text.trim(),
                institution: item.institutionController.text.trim(),
                duration: _formatDuration(item.startDate, item.endDate),
              ),
            )
            .toList(),
        courses: _courseItems.map(_courseToText).toList(),
        languages: _languagesController.text.trim(),
      ),
    );
  }

  String _courseToText(_CourseFormItem item) {
    return [
      item.titleController.text.trim(),
      item.providerController.text.trim(),
      _formatMonthYear(item.date),
    ].where((part) => part.isNotEmpty).join(', ');
  }

  List<String> _toList(String value) {
    return value
        .split(RegExp(r'[\n,]'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  String _formatDuration(DateTime? start, DateTime? end) {
    return '${_formatMonthYear(start)} - ${_formatMonthYear(end)}';
  }

  String _formatMonthYear(DateTime? date) {
    if (date == null) return '';
    return '${_monthNames[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CvCoachAppBar(
        title: 'Create CV',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: BlocConsumer<GenerateCvCubit, GenerateCvState>(
        listener: (context, state) {
          if (state is GenerateCvSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CvReadyScreen(pdfBytes: state.pdfBytes),
              ),
            );
          }
          if (state is GenerateCvError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is GenerateCvLookupsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<GenerateCvCubit>();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  const CvStatusHeader(
                    title: 'Create your CV',
                    subtitle:
                        'Fill your information and AI will generate a professional CV.',
                  ),
                  const SizedBox(height: 20),
                  if (state is GenerateCvLookupsLoading) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 16),
                  ],
                  _buildForm(context, state),
                  if (cubit.cachedPdf != null && state is! GenerateCvSuccess) ...[
                    const SizedBox(height: 24),
                    CvReadyCard(
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PdfViewerScreen(pdfBytes: cubit.cachedPdf!),
                          ),
                        );
                      },
                      onDownloadPdf: () => saveAndOpenPdf(cubit.cachedPdf!),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, GenerateCvState state) {
    final isLoading = state is GenerateCvLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Personal information'),
          _input(_nameController, 'Name', Icons.person_outline),
          _input(_jobTitleController, 'Job title', Icons.work_outline),
          _input(
            _emailController,
            'Email',
            Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          _input(
            _phoneController,
            'Phone',
            Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          _input(_addressController, 'Address', Icons.location_on_outlined),
          _input(
            _linkedinController,
            'LinkedIn',
            Icons.link,
            validator: (value) => _validatePlatformUrl(
              value,
              label: 'LinkedIn',
              allowedHosts: const ['linkedin.com', 'www.linkedin.com'],
            ),
          ),
          _input(
            _githubController,
            'GitHub',
            Icons.code,
            validator: (value) => _validatePlatformUrl(
              value,
              label: 'GitHub',
              allowedHosts: const ['github.com', 'www.github.com'],
            ),
          ),
          _pickerInput(
            context,
            _skillsController,
            'Skills',
            Icons.psychology_outlined,
            items: context
                .read<GenerateCvCubit>()
                .skills
                .map((skill) => skill.name)
                .toList(),
            searchHint: 'Search skills',
          ),
          _pickerInput(
            context,
            _languagesController,
            'Languages',
            Icons.language,
            items: _languageOptions,
            searchHint: 'Search languages',
          ),
          const SizedBox(height: 10),
          _buildExperienceSection(),
          const SizedBox(height: 20),
          _buildEducationSection(),
          const SizedBox(height: 20),
          _buildCoursesSection(),
          const SizedBox(height: 12),
          CustomElevatedButton(
            isLoading: isLoading,
            onPressed: isLoading ? () {} : () => _submit(context),
            widget: const Text(
              'Create',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return _buildDynamicSection(
      title: 'Experience',
      subtitle: 'Add your role, company, dates, and responsibilities.',
      addLabel: 'Add experience',
      onAdd: () {
        setState(() {
          _experienceItems.add(_ExperienceFormItem());
        });
      },
      children: List.generate(_experienceItems.length, (index) {
        final item = _experienceItems[index];
        return _buildEntryCard(
          title: 'Experience ${index + 1}',
          onRemove: _experienceItems.length == 1
              ? null
              : () {
                  setState(() {
                    final removed = _experienceItems.removeAt(index);
                    removed.dispose();
                  });
                },
          child: Column(
            children: [
              _input(item.roleController, 'Role', Icons.badge_outlined),
              _input(
                item.companyController,
                'Company',
                Icons.business_outlined,
              ),
              _input(
                item.locationController,
                'Location',
                Icons.location_city_outlined,
              ),
              Row(
                children: [
                  Expanded(
                    child: _dateInput(
                      controller: item.startDateController,
                      label: 'Start date',
                      icon: Icons.calendar_month_outlined,
                      onTap: () => _pickDate(
                        controller: item.startDateController,
                        initialDate: item.startDate,
                        onSelected: (date) => item.startDate = date,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dateInput(
                      controller: item.endDateController,
                      label: 'End date',
                      icon: Icons.event_outlined,
                      onTap: () => _pickDate(
                        controller: item.endDateController,
                        initialDate: item.endDate ?? item.startDate,
                        firstDate: item.startDate,
                        onSelected: (date) => item.endDate = date,
                      ),
                    ),
                  ),
                ],
              ),
              _input(
                item.responsibilitiesController,
                'Responsibilities',
                Icons.format_list_bulleted_outlined,
                hint: 'Write each responsibility in a new line',
                maxLines: 4,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEducationSection() {
    return _buildDynamicSection(
      title: 'Education',
      subtitle: 'Add your degree, institution, and study duration.',
      addLabel: 'Add education',
      onAdd: () {
        setState(() {
          _educationItems.add(_EducationFormItem());
        });
      },
      children: List.generate(_educationItems.length, (index) {
        final item = _educationItems[index];
        return _buildEntryCard(
          title: 'Education ${index + 1}',
          onRemove: _educationItems.length == 1
              ? null
              : () {
                  setState(() {
                    final removed = _educationItems.removeAt(index);
                    removed.dispose();
                  });
                },
          child: Column(
            children: [
              _input(item.degreeController, 'Degree', Icons.school_outlined),
              _input(
                item.institutionController,
                'Institution',
                Icons.apartment_outlined,
              ),
              Row(
                children: [
                  Expanded(
                    child: _dateInput(
                      controller: item.startDateController,
                      label: 'Start date',
                      icon: Icons.calendar_month_outlined,
                      onTap: () => _pickDate(
                        controller: item.startDateController,
                        initialDate: item.startDate,
                        onSelected: (date) => item.startDate = date,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dateInput(
                      controller: item.endDateController,
                      label: 'End date',
                      icon: Icons.event_outlined,
                      onTap: () => _pickDate(
                        controller: item.endDateController,
                        initialDate: item.endDate ?? item.startDate,
                        firstDate: item.startDate,
                        onSelected: (date) => item.endDate = date,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCoursesSection() {
    return _buildDynamicSection(
      title: 'Courses',
      subtitle: 'Add course title, provider, and completion date.',
      addLabel: 'Add course',
      onAdd: () {
        setState(() {
          _courseItems.add(_CourseFormItem());
        });
      },
      children: List.generate(_courseItems.length, (index) {
        final item = _courseItems[index];
        return _buildEntryCard(
          title: 'Course ${index + 1}',
          onRemove: _courseItems.length == 1
              ? null
              : () {
                  setState(() {
                    final removed = _courseItems.removeAt(index);
                    removed.dispose();
                  });
                },
          child: Column(
            children: [
              _input(
                item.titleController,
                'Course title',
                Icons.menu_book_outlined,
              ),
              _input(
                item.providerController,
                'Provider',
                Icons.account_balance_outlined,
              ),
              _dateInput(
                controller: item.dateController,
                label: 'Completion date',
                icon: Icons.calendar_today_outlined,
                onTap: () => _pickDate(
                  controller: item.dateController,
                  initialDate: item.date,
                  onSelected: (date) => item.date = date,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF14213D),
        ),
      ),
    );
  }

  Widget _buildDynamicSection({
    required String title,
    required String subtitle,
    required String addLabel,
    required VoidCallback onAdd,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildSectionTitle(title)),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle_outline),
              label: Text(addLabel),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildEntryCard({
    required String title,
    required Widget child,
    VoidCallback? onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8E1EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF14213D),
                  ),
                ),
              ),
              if (onRemove != null)
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remove',
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label,
    IconData icon, {
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.4),
          ),
        ),
      ),
    );
  }

  Widget _dateInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return _input(
      controller,
      label,
      icon,
      readOnly: true,
      onTap: onTap,
      hint: 'Select month and year',
    );
  }

  Future<void> _pickDate({
    required TextEditingController controller,
    required ValueChanged<DateTime> onSelected,
    DateTime? initialDate,
    DateTime? firstDate,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1990),
      lastDate: DateTime(now.year + 10, 12),
      helpText: 'Select date',
    );

    if (picked == null) return;

    final normalized = DateTime(picked.year, picked.month);
    onSelected(normalized);
    setState(() {
      controller.text = _formatMonthYear(normalized);
    });
  }

  String? _validatePlatformUrl(
    String? value, {
    required String label,
    required List<String> allowedHosts,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }

    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return 'Enter a valid $label URL';
    }

    final host = uri.host.toLowerCase();
    if (!allowedHosts.contains(host)) {
      return 'Use a valid $label link';
    }

    return null;
  }

  Widget _pickerInput(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon, {
    required List<String> items,
    required String searchHint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _openMultiSelectSheet(
          context,
          controller: controller,
          title: label,
          items: items,
          searchHint: searchHint,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Select $label',
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1.4),
          ),
        ),
      ),
    );
  }

  Future<void> _openMultiSelectSheet(
    BuildContext context, {
    required TextEditingController controller,
    required String title,
    required List<String> items,
    required String searchHint,
  }) async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$title data is still loading')));
      return;
    }

    final selected = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CvMultiSelectSheet(
        title: 'Select $title',
        items: items,
        initialSelectedItems: _toList(controller.text).toSet(),
        searchHint: searchHint,
      ),
    );

    if (selected == null) return;
    setState(() {
      controller.text = selected.join(', ');
    });
  }
}

class _ExperienceFormItem {
  final roleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  void dispose() {
    roleController.dispose();
    companyController.dispose();
    locationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    responsibilitiesController.dispose();
  }
}

class _EducationFormItem {
  final degreeController = TextEditingController();
  final institutionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  void dispose() {
    degreeController.dispose();
    institutionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}

class _CourseFormItem {
  final titleController = TextEditingController();
  final providerController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? date;

  void dispose() {
    titleController.dispose();
    providerController.dispose();
    dateController.dispose();
  }
}
