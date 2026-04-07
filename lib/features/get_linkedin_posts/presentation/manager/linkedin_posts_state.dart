import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';

class LinkedinPostsState {
  bool isLoadingLinkedinPosts;
  String errorMesLinkedinPosts;
  List<LinkedinPostEntity>? linkedinPostsList;

  LinkedinPostsState({
    this.linkedinPostsList,
    this.errorMesLinkedinPosts = '',
    this.isLoadingLinkedinPosts = false,
  });

  LinkedinPostsState copyWith({
    List<LinkedinPostEntity>? linkedinPostsList,
    bool? isLoadingLinkedinPosts,
    String? errorMesLinkedinPosts,
  }) {
    return LinkedinPostsState(
      isLoadingLinkedinPosts:
          isLoadingLinkedinPosts ?? this.isLoadingLinkedinPosts,
      errorMesLinkedinPosts:
          errorMesLinkedinPosts ?? this.errorMesLinkedinPosts,
      linkedinPostsList: linkedinPostsList ?? this.linkedinPostsList,
    );
  }
}
