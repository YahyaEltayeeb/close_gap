import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';

class ProfileState {
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
  final String? successMessage;
  final String name;
  final String email;
  final String role;
  final String? pathType;
  final int? universityId;
  final String? universityName;
  final int? facultyId;
  final String? facultyName;
  final int? departmentId;
  final String? departmentName;
  final AcademicLookupEntity? selectedTrack;
  final int? selectedYear;
  final SemesterLookupEntity? selectedSemester;
  final List<AcademicLookupEntity> tracks;
  final List<SemesterLookupEntity> semesters;

  const ProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
    this.successMessage,
    this.name = '',
    this.email = '',
    this.role = '',
    this.pathType,
    this.universityId,
    this.universityName,
    this.facultyId,
    this.facultyName,
    this.departmentId,
    this.departmentName,
    this.selectedTrack,
    this.selectedYear,
    this.selectedSemester,
    this.tracks = const [],
    this.semesters = const [],
  });

  bool get canEditAcademicProfile =>
      universityId != null && facultyId != null && departmentId != null;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    Object? errorMessage = _sentinel,
    Object? successMessage = _sentinel,
    String? name,
    String? email,
    String? role,
    Object? pathType = _sentinel,
    Object? universityId = _sentinel,
    Object? universityName = _sentinel,
    Object? facultyId = _sentinel,
    Object? facultyName = _sentinel,
    Object? departmentId = _sentinel,
    Object? departmentName = _sentinel,
    Object? selectedTrack = _sentinel,
    Object? selectedYear = _sentinel,
    Object? selectedSemester = _sentinel,
    List<AcademicLookupEntity>? tracks,
    List<SemesterLookupEntity>? semesters,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: successMessage == _sentinel
          ? this.successMessage
          : successMessage as String?,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      pathType: pathType == _sentinel ? this.pathType : pathType as String?,
      universityId: universityId == _sentinel
          ? this.universityId
          : universityId as int?,
      universityName: universityName == _sentinel
          ? this.universityName
          : universityName as String?,
      facultyId: facultyId == _sentinel ? this.facultyId : facultyId as int?,
      facultyName: facultyName == _sentinel
          ? this.facultyName
          : facultyName as String?,
      departmentId: departmentId == _sentinel
          ? this.departmentId
          : departmentId as int?,
      departmentName: departmentName == _sentinel
          ? this.departmentName
          : departmentName as String?,
      selectedTrack: selectedTrack == _sentinel
          ? this.selectedTrack
          : selectedTrack as AcademicLookupEntity?,
      selectedYear: selectedYear == _sentinel
          ? this.selectedYear
          : selectedYear as int?,
      selectedSemester: selectedSemester == _sentinel
          ? this.selectedSemester
          : selectedSemester as SemesterLookupEntity?,
      tracks: tracks ?? this.tracks,
      semesters: semesters ?? this.semesters,
    );
  }
}

const Object _sentinel = Object();
