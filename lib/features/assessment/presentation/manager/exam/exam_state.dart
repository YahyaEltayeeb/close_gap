part of 'exam_cubit.dart';

abstract class ExamState {
  const ExamState();
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<int, int> answers;
  final int remainingSeconds;

  const ExamLoaded({
    required this.questions,
    required this.currentIndex,
    required this.answers,
    required this.remainingSeconds,
  });

  QuestionEntity get currentQuestion => questions[currentIndex];
}

class ExamFinished extends ExamState {
  final ExamFinishEntity result;

  const ExamFinished(this.result);
}

class ExamInvalidated extends ExamState {
  const ExamInvalidated();
}

class ExamError extends ExamState {
  final String message;

  const ExamError(this.message);
}

class ExamWarning extends ExamState {
  final int strikes;

  const ExamWarning(this.strikes);
}