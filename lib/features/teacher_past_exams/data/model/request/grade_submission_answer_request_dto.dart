class GradeSubmissionAnswerRequestDto {
  final double? score;
  final String? feedback;

  const GradeSubmissionAnswerRequestDto({
    this.score,
    required this.feedback,
  });

  Map<String, dynamic> toJson() {
    return {
      if (score != null) 'score': score,
      if (feedback != null) 'feedback': feedback,
    };
  }
}
