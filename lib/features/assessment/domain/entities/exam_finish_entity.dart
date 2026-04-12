class ExamFinishEntity {
  final int? correctAnswers;
  final bool? invalidated;
  final int? score;
  final int? totalQuestions;
  final int? wrongAnswers;

  const ExamFinishEntity({
    this.correctAnswers,
    this.invalidated,
    this.score,
    this.totalQuestions,
    this.wrongAnswers,
  });
}