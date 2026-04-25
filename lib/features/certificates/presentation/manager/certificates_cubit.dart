import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/certificates/domain/entities/certificate_request_entity.dart';
import 'package:close_gap/features/certificates/domain/use_case/create_certificate_use_case.dart';
import 'package:close_gap/features/certificates/domain/use_case/get_certificate_courses_use_case.dart';
import 'package:close_gap/features/certificates/domain/use_case/get_certificate_skills_use_case.dart';
import 'package:close_gap/features/certificates/domain/use_case/get_certificates_use_case.dart';
import 'package:close_gap/features/certificates/presentation/manager/certificates_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CertificatesCubit extends Cubit<CertificatesState> {
  CertificatesCubit(
    this._getCertificatesUseCase,
    this._createCertificateUseCase,
    this._getCertificateSkillsUseCase,
    this._getCertificateCoursesUseCase,
  ) : super(const CertificatesState());

  final GetCertificatesUseCase _getCertificatesUseCase;
  final CreateCertificateUseCase _createCertificateUseCase;
  final GetCertificateSkillsUseCase _getCertificateSkillsUseCase;
  final GetCertificateCoursesUseCase _getCertificateCoursesUseCase;

  Future<void> loadData() async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, successMessage: null),
    );

    final certificatesResponse = await _getCertificatesUseCase();
    final skillsResponse = await _getCertificateSkillsUseCase();
    final coursesResponse = await _getCertificateCoursesUseCase();

    final certificates = switch (certificatesResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };
    final skills = switch (skillsResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };
    final courses = switch (coursesResponse) {
      ApiSuccessResult<List<dynamic>>(data: final data) => data.cast(),
      _ => <dynamic>[],
    };

    String? errorMessage;
    if (certificatesResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    } else if (skillsResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    } else if (coursesResponse case ApiErrorResult(failure: final failure)) {
      errorMessage = failure;
    }

    emit(
      state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        certificates: certificates.cast(),
        skills: skills.cast(),
        courses: courses.cast(),
      ),
    );
  }

  Future<bool> createCertificate(CertificateRequestEntity requestEntity) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await _createCertificateUseCase(requestEntity);
    if (result case ApiErrorResult(failure: final failure)) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure));
      return false;
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        successMessage: 'Certificate added successfully',
      ),
    );
    await loadData();
    return true;
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
