import 'package:flutter/material.dart';
import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/entities/analysis_entity.dart';
import 'package:close_gap/features/cv_coach/domain/entities/details_analysis_entity.dart';

class CvCoachResultScreen extends StatelessWidget {
  final CvAnalysisEntity cvAnalysisEntity;

  const CvCoachResultScreen({super.key, required this.cvAnalysisEntity});

  @override
  Widget build(BuildContext context) {
    final analysis = cvAnalysisEntity.analysis;
    final details = analysis.detailedAnalysis;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFileNameRow(cvAnalysisEntity.filename),
                  const SizedBox(height: 16),
                  _buildScoreCard(analysis),
                  const SizedBox(height: 16),
                  _buildScoreBreakdown(analysis),
                  const SizedBox(height: 16),
                  _buildCriticalIssues(analysis.weaknesses),
                  const SizedBox(height: 16),
                  _buildStrengths(analysis.strengths),
                  const SizedBox(height: 16),
                  _buildWeaknesses(analysis.weaknesses),
                  const SizedBox(height: 16),
                  _buildMissingSections(details.missingSections),
                  const SizedBox(height: 16),
                  _buildWhatToFix(analysis.recommendations),
                  const SizedBox(height: 16),
                  _buildInDepthAnalysis(details),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'CV Coach',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Create a professional CV now to apply for jobs',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileNameRow(String filename) {
    return Row(
      children: [
        const Icon(Icons.insert_drive_file_outlined,
            color: Color(0xFF2196F3), size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            filename,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2196F3),
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(AnalysisEntity analysis) {
    final score = analysis.overallScore;
    final atsText = analysis.detailedAnalysis.atsCompatibility;
    final isHighAts = atsText.toLowerCase().contains('high');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your ATS score',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                ' / 100',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ATS compatibility badge row
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildBadge(
                icon: Icons.verified_outlined,
                label: 'ATS Compatibility: ${isHighAts ? "High" : "Low"}',
                color: isHighAts ? Colors.green : Colors.red,
              ),
              _buildBadge(
                icon: Icons.search,
                label: 'Parsing: Good',
                color: Colors.green,
              ),
              _buildBadge(
                icon: Icons.key,
                label: 'Keywords: Strong',
                color: Colors.green,
              ),
              _buildBadge(
                icon: Icons.warning_amber_rounded,
                label: 'Risks: Found',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown(AnalysisEntity analysis) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Score Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildScoreBar('Formatting', analysis.formattingScore,
              const Color(0xFF4CAF50)),
          const SizedBox(height: 12),
          _buildScoreBar(
              'Content', analysis.contentScore, const Color(0xFF2196F3)),
          const SizedBox(height: 12),
          _buildScoreBar(
              'Keywords', analysis.keywordsScore, const Color(0xFF9C27B0)),
          const SizedBox(height: 12),
          _buildScoreBar(
              'Structure', analysis.structureScore, const Color(0xFFFF9800)),
        ],
      ),
    );
  }

  Widget _buildScoreBar(String label, int score, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$score%',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCriticalIssues(List<String> issues) {
    if (issues.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    const Icon(Icons.error_outline, color: Colors.red, size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'Critical issues detected',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...issues.take(3).map((issue) => _buildBulletItem(issue, Colors.red)),
        ],
      ),
    );
  }

  Widget _buildStrengths(List<String> strengths) {
    return _buildListSection(
      title: 'Strengths',
      items: strengths,
      icon: Icons.bolt,
      iconColor: const Color(0xFFFF9800),
      bulletColor: Colors.green,
    );
  }

  Widget _buildWeaknesses(List<String> weaknesses) {
    return _buildListSection(
      title: 'Weaknesses',
      items: weaknesses,
      icon: Icons.thumb_down_alt_outlined,
      iconColor: Colors.red,
      bulletColor: Colors.red,
    );
  }

  Widget _buildMissingSections(List<String> sections) {
    if (sections.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Missing sections',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          ...sections.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.remove_circle_outline,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(s,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatToFix(List<String> recommendations) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What to fix first?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...recommendations.map((rec) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Icon(Icons.circle,
                          size: 7, color: Color(0xFF2196F3)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        rec,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInDepthAnalysis(DetailedAnalysisEntity details) {
    return _ExpandableSection(
      title: 'In-Depth Analysis',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(
              'Formatting', details.formatting, const Color(0xFF4CAF50)),
          const SizedBox(height: 10),
          _buildDetailItem('Content', details.content, const Color(0xFF2196F3)),
          const SizedBox(height: 10),
          _buildDetailItem(
              'Keywords', details.keywords, const Color(0xFF9C27B0)),
          const SizedBox(height: 10),
          _buildDetailItem(
              'Structure', details.structure, const Color(0xFFFF9800)),
          if (details.missingSections.isNotEmpty) ...[
            const SizedBox(height: 10),
            _buildDetailItem(
              'Missing Sections',
              details.missingSections.join(', '),
              Colors.orange,
            ),
          ],
          const SizedBox(height: 10),
          _buildDetailItem(
            'Achievement Quality',
            details.achievementQuality,
            Colors.blueGrey,
          ),
          const SizedBox(height: 10),
          _buildDetailItem(
            'ATS Compatibility',
            details.atsCompatibility,
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String text, Color color) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color iconColor,
    required Color bulletColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => _buildBulletItem(item, bulletColor)),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 6, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// Expandable In-Depth Section
class _ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;

  const _ExpandableSection({required this.title, required this.child});

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined,
                      color: Color(0xFF2196F3), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}