class ExamAnswerEntity {
  final bool? isCorrect;
  final bool? ok;
  final int? remainingSeconds;

  const ExamAnswerEntity({
    this.isCorrect,
    this.ok,
    this.remainingSeconds,
  });
}