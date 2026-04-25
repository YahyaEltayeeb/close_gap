import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/core/network/api_services.dart';
import 'package:close_gap/core/services/token_service.dart';
import 'package:close_gap/features/auth/profile/presentation/manager/profile_state.dart';
import 'package:close_gap/features/auth/register/data/model/request/profile_setup_dto.dart';
import 'package:close_gap/features/auth/register/domain/entities/academic_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/entities/semester_lookup_entity.dart';
import 'package:close_gap/features/auth/register/domain/use_case/register_lookup_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel(
    this._tokenService,
    this._registerLookupUseCase,
    this._apiServices,
  ) : super(const ProfileState());

  final TokenService _tokenService;
  final RegisterLookupUseCase _registerLookupUseCase;
  final ApiServices _apiServices;

  Future<void> loadProfile() async {
    final savedName = _tokenService.getSavedName() ?? '';
    final savedEmail = _tokenService.getSavedEmail() ?? '';
    final savedRole = _tokenService.getSavedRole() ?? '';
    final savedTrackId = _tokenService.getSavedTrackId();
    final savedTrackName = _tokenService.getSavedTrackName();
    final savedYear = _tokenService.getSavedYear();
    final savedCurrentSemester = _tokenService.getSavedCurrentSemester();
    final savedUniversityId = _tokenService.getSavedUniversityId();
    final savedFacultyId = _tokenService.getSavedFacultyId();
    final savedDepartmentId = _tokenService.getSavedDepartmentId();

    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        successMessage: null,
        name: savedName,
        email: savedEmail,
        role: savedRole,
        pathType: _tokenService.getSavedPathType(),
        universityId: savedUniversityId,
        universityName: _tokenService.getSavedUniversityName(),
        facultyId: savedFacultyId,
        facultyName: _tokenService.getSavedFacultyName(),
        departmentId: savedDepartmentId,
        departmentName: _tokenService.getSavedDepartmentName(),
        selectedYear: savedYear,
      ),
    );

    final tracksResult = await _registerLookupUseCase.getTracks();
    final semestersResult = savedDepartmentId == null
        ? ApiSuccessResult<List<SemesterLookupEntity>>(data: const [])
        : await _registerLookupUseCase.getAvailableSemesters(savedDepartmentId);

    switch ((tracksResult, semestersResult)) {
      case (
        ApiSuccessResult(data: final tracks),
        ApiSuccessResult(data: final semesters),
      ):
        final resolvedTracks = _mergeTrackFallback(
          tracks: tracks,
          selectedTrackId: savedTrackId,
          selectedTrackName: savedTrackName,
        );
        final resolvedTrack = _findTrack(
          resolvedTracks,
          selectedTrackId: savedTrackId,
          selectedTrackName: savedTrackName,
        );
        final resolvedSemester = _findSemester(
          semesters,
          year: savedYear,
          semester: savedCurrentSemester,
        );

        emit(
          state.copyWith(
            isLoading: false,
            tracks: resolvedTracks,
            semesters: semesters,
            selectedTrack: resolvedTrack,
            selectedSemester:
                resolvedSemester ??
                _buildFallbackSemester(
                  year: savedYear,
                  semester: savedCurrentSemester,
                ),
          ),
        );
      case (ApiErrorResult(failure: final failure), _):
        emit(state.copyWith(isLoading: false, errorMessage: failure));
      case (_, ApiErrorResult(failure: final failure)):
        emit(state.copyWith(isLoading: false, errorMessage: failure));
    }
  }

  void onTrackChanged(String? value) {
    final selected = _findTrack(state.tracks, selectedTrackName: value);
    emit(state.copyWith(selectedTrack: selected, successMessage: null));
  }

  void onYearChanged(String? value) {
    final parsedYear = int.tryParse(value ?? '');
    final matchingSemester = state.semesters.firstWhere(
      (item) =>
          item.year == parsedYear &&
          item.semester == state.selectedSemester?.semester,
      orElse: () =>
          const SemesterLookupEntity(semester: -1, year: -1, label: ''),
    );

    emit(
      state.copyWith(
        selectedYear: parsedYear,
        selectedSemester: matchingSemester.semester == -1
            ? null
            : matchingSemester,
        successMessage: null,
      ),
    );
  }

  void onSemesterChanged(String? value) {
    final selected = state.semesters.where((item) {
      final sameYear =
          state.selectedYear == null || item.year == state.selectedYear;
      return sameYear && item.label == value;
    }).firstOrNull;

    emit(state.copyWith(selectedSemester: selected, successMessage: null));
  }

  Future<void> saveProfile() async {
    if (!state.canEditAcademicProfile) {
      emit(
        state.copyWith(
          errorMessage:
              'Profile data is incomplete. Please log in again before editing.',
        ),
      );
      return;
    }

    if (state.selectedTrack == null ||
        state.selectedYear == null ||
        state.selectedSemester == null) {
      emit(
        state.copyWith(errorMessage: 'Track, year and semester are required.'),
      );
      return;
    }

    emit(
      state.copyWith(isSaving: true, errorMessage: null, successMessage: null),
    );

    try {
      await _apiServices.setupProfile(
        ProfileSetupDto(
          universityId: state.universityId!,
          facultyId: state.facultyId!,
          departmentId: state.departmentId!,
          targetTrackId: state.selectedTrack!.id,
          year: state.selectedYear!,
          currentSemester: state.selectedSemester!.semester,
          pathType: state.pathType ?? 'student',
        ),
      );

      await _tokenService.saveAcademicProfile(
        trackId: state.selectedTrack!.id,
        trackName: state.selectedTrack!.name,
        year: state.selectedYear,
        currentSemester: state.selectedSemester!.semester,
        pathType: state.pathType,
        universityId: state.universityId,
        universityName: state.universityName,
        facultyId: state.facultyId,
        facultyName: state.facultyName,
        departmentId: state.departmentId,
        departmentName: state.departmentName,
      );

      emit(
        state.copyWith(
          isSaving: false,
          successMessage: 'Profile updated successfully.',
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(isSaving: false, errorMessage: _extractErrorMessage(e)),
      );
    } catch (e) {
      emit(state.copyWith(isSaving: false, errorMessage: e.toString()));
    }
  }

  AcademicLookupEntity? _buildFallbackTrack(int? trackId, String? trackName) {
    if (trackId == null || trackName == null || trackName.trim().isEmpty) {
      return null;
    }
    return AcademicLookupEntity(id: trackId, name: trackName.trim());
  }

  SemesterLookupEntity? _buildFallbackSemester({
    required int? year,
    required int? semester,
  }) {
    if (year == null || semester == null) {
      return null;
    }
    return SemesterLookupEntity(
      semester: semester,
      year: year,
      label: 'Semester $semester',
    );
  }

  List<AcademicLookupEntity> _mergeTrackFallback({
    required List<AcademicLookupEntity> tracks,
    required int? selectedTrackId,
    required String? selectedTrackName,
  }) {
    final fallback = _buildFallbackTrack(selectedTrackId, selectedTrackName);
    if (fallback == null) return tracks;

    final alreadyExists = tracks.any((item) => item.id == fallback.id);
    if (alreadyExists) return tracks;

    return [fallback, ...tracks];
  }

  AcademicLookupEntity? _findTrack(
    List<AcademicLookupEntity> tracks, {
    int? selectedTrackId,
    String? selectedTrackName,
  }) {
    for (final item in tracks) {
      if (selectedTrackId != null && item.id == selectedTrackId) {
        return item;
      }
      if (selectedTrackName != null && item.name == selectedTrackName) {
        return item;
      }
    }
    return null;
  }

  SemesterLookupEntity? _findSemester(
    List<SemesterLookupEntity> semesters, {
    required int? year,
    required int? semester,
  }) {
    for (final item in semesters) {
      if (item.year == year && item.semester == semester) {
        return item;
      }
    }
    return null;
  }

  String _extractErrorMessage(DioException exception) {
    final responseData = exception.response?.data;

    if (responseData is Map<String, dynamic>) {
      final detail = responseData['detail'];
      if (detail is String && detail.trim().isNotEmpty) {
        return detail.trim();
      }
      final message = responseData['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    } else if (responseData is String && responseData.trim().isNotEmpty) {
      return responseData.trim();
    }

    return exception.message ?? 'Failed to update profile.';
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
