import 'package:close_gap/features/compare_cv/domain/entities/compare_cv_result_entity.dart';

class CompareCvState {
  bool isLoadingCompareCv;
  String errorMesCompareCv;
  CompareCvResultEntity? compareCvResult;

  CompareCvState({
    this.compareCvResult,
    this.errorMesCompareCv = '',
    this.isLoadingCompareCv = false,
  });

  CompareCvState copyWith({
    CompareCvResultEntity? compareCvResult,
    bool? isLoadingCompareCv,
    String? errorMesCompareCv,
  }) {
    return CompareCvState(
      isLoadingCompareCv: isLoadingCompareCv ?? this.isLoadingCompareCv,
      errorMesCompareCv: errorMesCompareCv ?? this.errorMesCompareCv,
      compareCvResult: compareCvResult ?? this.compareCvResult,
    );
  }
}
