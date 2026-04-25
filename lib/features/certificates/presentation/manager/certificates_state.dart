import 'package:close_gap/features/certificates/domain/entities/certificate_item.dart';
import 'package:close_gap/features/certificates/domain/entities/course_option_entity.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';

class CertificatesState {
  static const _sentinel = Object();

  const CertificatesState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.certificates = const [],
    this.skills = const [],
    this.courses = const [],
  });

  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final List<CertificateItem> certificates;
  final List<SkillEntity> skills;
  final List<CourseOptionEntity> courses;

  CertificatesState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    List<CertificateItem>? certificates,
    List<SkillEntity>? skills,
    List<CourseOptionEntity>? courses,
  }) {
    return CertificatesState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _sentinel)
          ? this.successMessage
          : successMessage as String?,
      certificates: certificates ?? this.certificates,
      skills: skills ?? this.skills,
      courses: courses ?? this.courses,
    );
  }
}
