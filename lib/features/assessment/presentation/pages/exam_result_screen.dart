import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/config/routing/routing_extensions.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExamResultScreen extends StatefulWidget {
  final bool invalidated;
  final ExamFinishEntity? result;
  final int trackId;

  const ExamResultScreen({
    super.key,
    required this.invalidated,
    this.result,
    required this.trackId,
  });

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scoreAnim;
  bool _showReason = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scoreAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  int get score => widget.invalidated ? 0 : (widget.result?.score ?? 0);
  int get correct => widget.invalidated ? 0 : (widget.result?.correctAnswers ?? 0);
  int get wrong => widget.invalidated ? 0 : (widget.result?.wrongAnswers ?? 0);
  int get total => widget.result?.totalQuestions ?? 0;

  String get scoreLabel {
    if (widget.invalidated) return 'Assessment Rejected';
    if (score >= 90) return 'Outstanding!';
    if (score >= 75) return 'Great Effort!';
    if (score >= 60) return 'Good Job!';
    return 'Keep Practicing!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close, size: 18, color: Color(0xFF374151)),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Assessment Result',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827)),
                    ),

                    const SizedBox(height: 20),

                    // Score card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        children: [
                          // Circular progress
                          AnimatedBuilder(
                            animation: _scoreAnim,
                            builder: (context, _) {
                              final animScore = (score * _scoreAnim.value).round();
                              return SizedBox(
                                width: 140,
                                height: 140,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: const Size(140, 140),
                                      painter: _ScoreCirclePainter(
                                        progress: score / 100 * _scoreAnim.value,
                                        invalidated: widget.invalidated,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '$animScore%',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            color: widget.invalidated
                                                ? const Color(0xFF6B7280)
                                                : const Color(0xFF111827),
                                          ),
                                        ),
                                        const Text(
                                          'your score',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF9CA3AF)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Label
                          if (widget.invalidated)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.warning_rounded,
                                    color: Color(0xFFEF4444), size: 20),
                                SizedBox(width: 6),
                                Text(
                                  'Assessment Rejected',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFEF4444)),
                                ),
                              ],
                            )
                          else
                            Text(
                              scoreLabel,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF111827)),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Stats row
                    Row(
                      children: [
                        _StatBox(
                          value: '${_formatTime(widget.result)}',
                          label: 'Time taken',
                          color: const Color(0xFF2563EB),
                        ),
                        const SizedBox(width: 10),
                        _StatBox(
                          value: '$wrong',
                          label: 'Wrong',
                          color: const Color(0xFFEF4444),
                        ),
                        const SizedBox(width: 10),
                        _StatBox(
                          value: '$correct',
                          label: 'Correct',
                          color: const Color(0xFF22C55E),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Reason for rejection (invalidated only)
                    if (widget.invalidated) ...[
                      GestureDetector(
                        onTap: () => setState(() => _showReason = !_showReason),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8)
                            ],
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Reason for rejection',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF2563EB)),
                                ),
                              ),
                              Icon(
                                _showReason
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: const Color(0xFF2563EB),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_showReason)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8)
                            ],
                          ),
                          child: Column(
                            children: [
                              'Detected holding a mobile phone during the assessment.',
                              'Your Assessment submission has been rejected due to violations of assessment rule.',
                              'You have 3 more attempts to retake this assessment.',
                            ]
                                .map((t) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('• ',
                                              style: TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 13)),
                                          Expanded(
                                            child: Text(
                                              t,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF6B7280),
                                                  height: 1.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.invalidated) {
                          context.pushNamedAndRemoveUntil(
                            AppRoutes.instructionspage,
                            arguments: widget.trackId,
                            predicate: (route) => false,
                          );
                          return;
                        }

                        context.pushNamed(
                          AppRoutes.learningPlan,
                          arguments: widget.trackId,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        widget.invalidated
                            ? 'Retake Assessment (3 attempts left)'
                            : 'Create learning plan',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF374151),
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(ExamFinishEntity? result) {
    // placeholder — لو عندك elapsed time من الـ cubit ممكن تبعتها
    return '12:30';
  }
}

// ── STAT BOX ─────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF9CA3AF))),
          ],
        ),
      ),
    );
  }
}

// ── SCORE CIRCLE PAINTER ──────────────────────────────────
class _ScoreCirclePainter extends CustomPainter {
  final double progress;
  final bool invalidated;

  _ScoreCirclePainter({required this.progress, required this.invalidated});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 10.0;

    // Background circle
    final bgPaint = Paint()
      ..color = const Color(0xFFF3F4F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = invalidated ? const Color(0xFFD1D5DB) : const Color(0xFF2563EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ScoreCirclePainter old) =>
      old.progress != progress || old.invalidated != invalidated;
}
