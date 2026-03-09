import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/get_linkedin_posts/domain/use_case/linkedin_posts_use_case.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_event.dart';
import 'package:close_gap/features/get_linkedin_posts/presentation/manager/linkedin_posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LinkedinPostsViewModel extends Cubit<LinkedinPostsState> {
  final LinkedinPostsUseCase _linkedinPostsUseCase;
  LinkedinPostsViewModel(this._linkedinPostsUseCase)
      : super(LinkedinPostsState());

  void doIntent(LinkedinPostsEvent event) {
    switch (event) {
      case SubmitLinkedinPostsEvent():
        _getLinkedinPosts();
    }
  }

  void _getLinkedinPosts() async {
    emit(state.copyWith(isLoadingLinkedinPosts: true));
    var result = await _linkedinPostsUseCase.call();
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isLoadingLinkedinPosts: false,
            linkedinPostsList: result.data,
          ),
        );
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoadingLinkedinPosts: false,
            errorMesLinkedinPosts: result.failure.toString(),
          ),
        );
    }
  }
}
