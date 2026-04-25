import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/domain/entities/experience_request_entity.dart';
import 'package:close_gap/features/experience/domain/use_case/create_experience_use_case.dart';
import 'package:close_gap/features/experience/domain/use_case/delete_experience_use_case.dart';
import 'package:close_gap/features/experience/domain/use_case/get_experiences_use_case.dart';
import 'package:close_gap/features/experience/domain/use_case/update_experience_use_case.dart';
import 'package:close_gap/features/experience/presentation/manager/experience_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit(
    this._getExperiencesUseCase,
    this._createExperienceUseCase,
    this._updateExperienceUseCase,
    this._deleteExperienceUseCase,
  ) : super(const ExperienceState());

  final GetExperiencesUseCase _getExperiencesUseCase;
  final CreateExperienceUseCase _createExperienceUseCase;
  final UpdateExperienceUseCase _updateExperienceUseCase;
  final DeleteExperienceUseCase _deleteExperienceUseCase;

  Future<void> loadExperiences() async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final result = await _getExperiencesUseCase();
    switch (result) {
      case ApiSuccessResult(data: final data):
        emit(state.copyWith(isLoading: false, experiences: data));
      case ApiErrorResult(failure: final failure):
        emit(state.copyWith(isLoading: false, errorMessage: failure));
    }
  }

  Future<bool> createExperience(ExperienceRequestEntity requestEntity) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _createExperienceUseCase(requestEntity);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure));
      return false;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        successMessage: 'Experience added successfully',
      ),
    );
    await loadExperiences();
    return true;
  }

  Future<bool> updateExperience(
    int experienceId,
    ExperienceRequestEntity requestEntity,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _updateExperienceUseCase(experienceId, requestEntity);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure));
      return false;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        successMessage: 'Experience updated successfully',
      ),
    );
    await loadExperiences();
    return true;
  }

  Future<void> deleteExperience(int experienceId) async {
    emit(
      state.copyWith(
        isDeleting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _deleteExperienceUseCase(experienceId);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isDeleting: false, errorMessage: failure));
      return;
    }

    emit(
      state.copyWith(
        isDeleting: false,
        successMessage: 'Experience deleted successfully',
      ),
    );
    await loadExperiences();
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
