class StartExamEntity {
  final ExamEntity? exam;
  final int? remainingSeconds;

  const StartExamEntity({
    this.exam,
    this.remainingSeconds,
  });
}

class ExamEntity {
  final bool? active;
  final List<AnswerEntity>? answers;
  final List<dynamic>? events;
  final dynamic finishedAt;
  final int? id;
  final bool? invalidated;
  final int? score;
  final DateTime? startedAt;
  final int? strikes;
  final int? trackId;
  final int? userId;

  const ExamEntity({
    this.active,
    this.answers,
    this.events,
    this.finishedAt,
    this.id,
    this.invalidated,
    this.score,
    this.startedAt,
    this.strikes,
    this.trackId,
    this.userId,
  });
}

class AnswerEntity {
  final int? chosenOptionId;
  final int? examId;
  final int? id;
  final bool? isCorrect;
  final int? questionId;

  const AnswerEntity({
    this.chosenOptionId,
    this.examId,
    this.id,
    this.isCorrect,
    this.questionId,
  });
}