import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/projects/domain/entities/project_entity.dart';
import 'package:close_gap/features/projects/presentation/widgets/project_skill_chip.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    this.isOwnedProject = false,
    this.isBusy = false,
    this.onDelete,
  });

  final ProjectEntity project;
  final bool isOwnedProject;
  final bool isBusy;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title.isEmpty
                          ? 'Untitled Project'
                          : project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (project.description.isNotEmpty)
                      Text(
                        project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.45,
                        ),
                      ),
                  ],
                ),
              ),
              if (isOwnedProject)
                IconButton(
                  onPressed: isBusy ? null : onDelete,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.red,
                  ),
                  tooltip: 'Delete project',
                ),
            ],
          ),
          if (project.skills.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.skills
                  .map((skill) => ProjectSkillChip(label: skill))
                  .toList(),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              if (project.githubUrl.isNotEmpty)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openUrl(project.githubUrl),
                    icon: const Icon(Icons.code_rounded),
                    label: const Text('GitHub'),
                  ),
                ),
              if (project.githubUrl.isNotEmpty && project.demoUrl.isNotEmpty)
                const SizedBox(width: 10),
              if (project.demoUrl.isNotEmpty)
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _openUrl(project.demoUrl),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                    ),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text('Demo'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
