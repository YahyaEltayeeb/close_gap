import 'package:close_gap/features/experience/domain/entities/experience_item.dart';

class ExperienceState {
  static const _sentinel = Object();

  const ExperienceState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.isDeleting = false,
    this.errorMessage,
    this.successMessage,
    this.experiences = const [],
  });

  final bool isLoading;
  final bool isSubmitting;
  final bool isDeleting;
  final String? errorMessage;
  final String? successMessage;
  final List<ExperienceItem> experiences;

  ExperienceState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    bool? isDeleting,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    List<ExperienceItem>? experiences,
  }) {
    return ExperienceState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      experiences: experiences ?? this.experiences,
    );
  }
}
