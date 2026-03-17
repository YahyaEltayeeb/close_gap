import 'dart:typed_data';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/generate_cv/domain/use_case/genetate_cv_use_case.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class GenerateCvCubit extends Cubit<GenerateCvState> {
  final GenerateCvUseCase useCase;

  GenerateCvCubit(this.useCase,) : super(GenerateCvInitial());

  Uint8List? cachedPdf;

  Future<void> generateCv() async {
    emit(GenerateCvLoading());

    final result = await useCase();

    switch (result) {
      case ApiSuccessResult<List<int>>(:final data):
        cachedPdf = Uint8List.fromList(data);
        emit(GenerateCvSuccess(cachedPdf!));

      case ApiErrorResult(:final failure):
        emit(GenerateCvError(failure));
    }
  }
}
