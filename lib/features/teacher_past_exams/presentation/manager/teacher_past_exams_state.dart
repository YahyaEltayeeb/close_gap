import 'package:close_gap/features/teacher_past_exams/domain/entities/teacher_exam_list_item_entity.dart';

class TeacherPastExamsState {
  final bool isLoading;
  final String? errorMessage;
  final List<TeacherExamListItemEntity> exams;

  const TeacherPastExamsState({
    this.isLoading = false,
    this.errorMessage,
    this.exams = const [],
  });

  TeacherPastExamsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TeacherExamListItemEntity>? exams,
  }) {
    return TeacherPastExamsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      exams: exams ?? this.exams,
    );
  }
}
