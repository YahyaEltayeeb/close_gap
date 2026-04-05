import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/user_register_entity.dart';

class RegisterState {
  final bool isLoading;
  final bool isLookupLoading;
  final String? errorMessage;
  final String? lookupErrorMessage;
  final bool isSuccess;
  final UserEntity? userEntity;
  final List<AcademicLookupEntity> universities;
  final List<AcademicLookupEntity> faculties;
  final List<AcademicLookupEntity> departments;
  final List<AcademicLookupEntity> tracks;
  final List<SemesterLookupEntity> semesters;

  RegisterState({
    this.isLoading = false,
    this.isLookupLoading = false,
    this.errorMessage,
    this.lookupErrorMessage,
    this.isSuccess = false,
    this.userEntity,
    this.universities = const [],
    this.faculties = const [],
    this.departments = const [],
    this.tracks = const [],
    this.semesters = const [],
  });

  RegisterState copyWith({
    UserEntity? userEntity,
    bool? isLoading,
    bool? isLookupLoading,
    Object? errorMessage = _sentinel,
    Object? lookupErrorMessage = _sentinel,
    bool? isSuccess,
    List<AcademicLookupEntity>? universities,
    List<AcademicLookupEntity>? faculties,
    List<AcademicLookupEntity>? departments,
    List<AcademicLookupEntity>? tracks,
    List<SemesterLookupEntity>? semesters,
  }) {
    return RegisterState(
      userEntity: userEntity ?? this.userEntity,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
      isLookupLoading: isLookupLoading ?? this.isLookupLoading,
      lookupErrorMessage: lookupErrorMessage == _sentinel
          ? this.lookupErrorMessage
          : lookupErrorMessage as String?,
      isSuccess: isSuccess ?? this.isSuccess,
      universities: universities ?? this.universities,
      faculties: faculties ?? this.faculties,
      departments: departments ?? this.departments,
      tracks: tracks ?? this.tracks,
      semesters: semesters ?? this.semesters,
    );
  }
}

const Object _sentinel = Object();
