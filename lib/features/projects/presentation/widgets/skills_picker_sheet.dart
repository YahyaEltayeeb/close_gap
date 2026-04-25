import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:flutter/material.dart';

class SkillsPickerSheet extends StatefulWidget {
  const SkillsPickerSheet({
    super.key,
    required this.skills,
    required this.initialSelectedSkills,
  });

  final List<SkillEntity> skills;
  final Set<String> initialSelectedSkills;

  @override
  State<SkillsPickerSheet> createState() => _SkillsPickerSheetState();
}

class _SkillsPickerSheetState extends State<SkillsPickerSheet> {
  final _searchController = TextEditingController();
  late final Set<String> _tempSelectedSkills;

  @override
  void initState() {
    super.initState();
    _tempSelectedSkills = {...widget.initialSelectedSkills};
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredSkills = widget.skills.where((skill) {
      if (query.isEmpty) return true;
      return skill.name.toLowerCase().contains(query);
    }).toList()..sort((a, b) => a.name.compareTo(b.name));

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
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                'Select Skills',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              Text(
                'Search and choose more than one skill.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search skills',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: filteredSkills.isEmpty
                    ? Center(
                        child: Text(
                          'No matching skills',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredSkills.length,
                        itemBuilder: (context, index) {
                          final skill = filteredSkills[index];
                          final isSelected = _tempSelectedSkills.contains(
                            skill.name,
                          );
                          return CheckboxListTile(
                            value: isSelected,
                            contentPadding: EdgeInsets.zero,
                            activeColor: AppColors.lightPrimary,
                            title: Text(skill.name),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (_) {
                              setState(() {
                                if (isSelected) {
                                  _tempSelectedSkills.remove(skill.name);
                                } else {
                                  _tempSelectedSkills.add(skill.name);
                                }
                              });
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () =>
                      Navigator.of(context).pop(_tempSelectedSkills),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
