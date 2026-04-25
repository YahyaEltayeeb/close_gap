import 'dart:typed_data';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/experience/domain/entities/experience_item.dart';
import 'package:close_gap/features/experience/domain/use_case/get_experiences_use_case.dart';
import 'package:close_gap/features/generate_cv/domain/entities/generate_cv_request_entity.dart';
import 'package:close_gap/features/generate_cv/domain/use_case/genetate_cv_use_case.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_state.dart';
import 'package:close_gap/features/projects/domain/entities/skill_entity.dart';
import 'package:close_gap/features/projects/domain/use_case/get_skills_use_case.dart';
import 'package:close_gap/features/teacher_exams/domain/entities/academic_course_entity.dart';
import 'package:close_gap/features/teacher_exams/domain/use_case/get_academic_courses_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateCvCubit extends Cubit<GenerateCvState> {
  final GenerateCvUseCase useCase;
  final GetSkillsUseCase _getSkillsUseCase;
  final GetAcademicCoursesUseCase _getAcademicCoursesUseCase;
  final GetExperiencesUseCase _getExperiencesUseCase;

  GenerateCvCubit(
    this.useCase,
    this._getSkillsUseCase,
    this._getAcademicCoursesUseCase,
    this._getExperiencesUseCase,
  ) : super(GenerateCvInitial());

  Uint8List? cachedPdf;
  List<SkillEntity> skills = const [];
  List<AcademicCourseEntity> courses = const [];
  List<ExperienceItem> experiences = const [];

  Future<void> loadLookups() async {
    emit(GenerateCvLookupsLoading());

    final skillsResult = await _getSkillsUseCase();
    final coursesResult = await _getAcademicCoursesUseCase();
    final experiencesResult = await _getExperiencesUseCase();

    if (skillsResult case ApiSuccessResult<List<SkillEntity>>(
      data: final data,
    )) {
      skills = data;
    }
    if (coursesResult case ApiSuccessResult<List<AcademicCourseEntity>>(
      data: final data,
    )) {
      courses = data;
    }
    if (experiencesResult case ApiSuccessResult<List<ExperienceItem>>(
      data: final data,
    )) {
      experiences = data;
    }

    final error = switch ((skillsResult, coursesResult, experiencesResult)) {
      (ApiErrorResult(failure: final failure), _, _) => failure,
      (_, ApiErrorResult(failure: final failure), _) => failure,
      (_, _, ApiErrorResult(failure: final failure)) => failure,
      _ => null,
    };

    if (error != null) {
      emit(GenerateCvLookupsError(error));
      return;
    }

    emit(GenerateCvLookupsReady());
  }

  Future<void> generateCv(GenerateCvRequestEntity requestEntity) async {
    emit(GenerateCvLoading());

    final result = await useCase(requestEntity);

    switch (result) {
      case ApiSuccessResult<List<int>>(:final data):
        cachedPdf = Uint8List.fromList(data);
        emit(GenerateCvSuccess(cachedPdf!));

      case ApiErrorResult(:final failure):
        emit(GenerateCvError(failure));
    }
  }
}
