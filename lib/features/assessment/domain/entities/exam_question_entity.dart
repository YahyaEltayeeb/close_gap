enum LevelEntity {
  basic,
}

class OptionEntity {
  final int? id;
  final int? questionId;
  final String? text;

  const OptionEntity({
    this.id,
    this.questionId,
    this.text,
  });
}

class QuestionEntity {
  final LevelEntity? difficulty;
  final int? id;
  final List<OptionEntity>? options;
  final String? text;

  const QuestionEntity({
    this.difficulty,
    this.id,
    this.options,
    this.text,
  });
}

class ExamQuestionsEntity {
  final LevelEntity? level;
  final int? page;
  final int? perPage;
  final List<QuestionEntity>? questions;
  final int? totalQuestions;
  final String? track;

  const ExamQuestionsEntity({
    this.level,
    this.page,
    this.perPage,
    this.questions,
    this.totalQuestions,
    this.track,
  });
}