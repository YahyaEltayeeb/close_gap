import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/auth/register/domain/use_case/register_lookup_use_case.dart';
import 'package:close_gap/features/auth/register/domain/entities/register_request_entity.dart';
import 'package:close_gap/features/auth/register/domain/use_case/register_use_case.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_event.dart';
import 'package:close_gap/features/auth/register/presentation/manager/register_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  RegisterViewModel(this._registerUseCase, this._registerLookupUseCase)
    : super(RegisterState());
  final RegisterUseCase _registerUseCase;
  final RegisterLookupUseCase _registerLookupUseCase;

  void clearSubmissionFeedback() {
    if (state.errorMessage == null && !state.isSuccess) return;
    emit(state.copyWith(errorMessage: null, isSuccess: false));
  }

  void doIntent(RegisterEvent event) {
    switch (event) {
      case RegisterSubmitEvent():
        registerUser(event.requestEntity);
    }
  }

  void registerUser(RegisterRequestEntity requestEntity) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    var result = await _registerUseCase.call(requestEntity);
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            isSuccess: true,
            userEntity: result.data,
          ),
        );
      case ApiErrorResult():
        emit(state.copyWith(isLoading: false, errorMessage: result.failure));
    }
  }

  Future<void> loadInitialStudentData() async {
    emit(
      state.copyWith(
        isLookupLoading: true,
        lookupErrorMessage: null,
        faculties: [],
        departments: [],
        semesters: [],
      ),
    );

    final universitiesResult = await _registerLookupUseCase.getUniversities();
    final tracksResult = await _registerLookupUseCase.getTracks();

    switch ((universitiesResult, tracksResult)) {
      case (
        ApiSuccessResult(data: final universities),
        ApiSuccessResult(data: final tracks),
      ):
        emit(
          state.copyWith(
            isLookupLoading: false,
            universities: universities,
            tracks: tracks,
          ),
        );
      case (ApiErrorResult(failure: final failure), _):
        emit(
          state.copyWith(isLookupLoading: false, lookupErrorMessage: failure),
        );
      case (_, ApiErrorResult(failure: final failure)):
        emit(
          state.copyWith(isLookupLoading: false, lookupErrorMessage: failure),
        );
    }
  }

  Future<void> loadFaculties(int universityId) async {
    emit(
      state.copyWith(
        isLookupLoading: true,
        lookupErrorMessage: null,
        faculties: [],
        departments: [],
        semesters: [],
      ),
    );

    final result = await _registerLookupUseCase.getFaculties(universityId);
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isLookupLoading: false,
            faculties: data,
            departments: [],
            semesters: [],
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(isLookupLoading: false, lookupErrorMessage: failure),
        );
    }
  }

  Future<void> loadDepartments(int facultyId) async {
    emit(
      state.copyWith(
        isLookupLoading: true,
        lookupErrorMessage: null,
        departments: [],
        semesters: [],
      ),
    );

    final result = await _registerLookupUseCase.getDepartments(facultyId);
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(
          state.copyWith(
            isLookupLoading: false,
            departments: data,
            semesters: [],
          ),
        );
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(isLookupLoading: false, lookupErrorMessage: failure),
        );
    }
  }

  Future<void> loadSemesters(int departmentId) async {
    emit(
      state.copyWith(
        isLookupLoading: true,
        lookupErrorMessage: null,
        semesters: [],
      ),
    );

    final result = await _registerLookupUseCase.getAvailableSemesters(
      departmentId,
    );
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(state.copyWith(isLookupLoading: false, semesters: data));
      case ApiErrorResult(failure: final failure):
        emit(
          state.copyWith(isLookupLoading: false, lookupErrorMessage: failure),
        );
    }
  }
}
