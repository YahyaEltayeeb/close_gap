import 'package:close_gap/features/cv_coach/domain/entities/cv_analysis_entity.dart';

class CvCoashState {
  bool isLoaddingCvCoash;
  String errorMesCvCoash;
  CvAnalysisEntity? cvAnalysisEntity;
  CvCoashState({
    this.cvAnalysisEntity,
    this.errorMesCvCoash = '',
    this.isLoaddingCvCoash = false,
  });

  CvCoashState copyWith({
    bool? isLoaddingCvCoash,
    String? errorMesCvCoash,
    CvAnalysisEntity? cvAnalysisEntity,
  }) {
    return CvCoashState(
      isLoaddingCvCoash: isLoaddingCvCoash ?? this.isLoaddingCvCoash,
      errorMesCvCoash: errorMesCvCoash ?? this.errorMesCvCoash,
      cvAnalysisEntity: cvAnalysisEntity ?? this.cvAnalysisEntity,
    );
  }
}
