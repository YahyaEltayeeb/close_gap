import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';
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
    
    // Mock data instead of API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    final mockPosts = [
      const LinkedinPostEntity(
        jobTitle: "AI Engineer",
        companyName: "Waystone",
        requiredSkills: [".NET", "Python", "TypeScript", "APIs", "microservices"],
        preferredSkills: ["LangChain", "RAG", "embeddings"],
        experienceYears: "5+ years",
        educationRequired: ["Computer Science", "Engineering"],
        languagesRequired: ["English"],
        jobDescription: "A hands-on AI Engineer role focused on embedding AI into real-world systems and building intelligent, scalable solutions. Responsibilities include designing AI-enabled solutions, integrating agentic workflows, and enhancing automation platforms.",
        postUrl: "https://www.linkedin.com/feed/update/urn:li:activity:7430617605750644736",
        hrEmail: "careers.india-technology@waystone.com",
      ),
      const LinkedinPostEntity(
        jobTitle: "Senior Flutter Developer",
        companyName: "TechCorp",
        requiredSkills: ["Flutter", "Dart", "Firebase", "REST APIs"],
        preferredSkills: ["BLoC", "Clean Architecture"],
        experienceYears: "3+ years",
        educationRequired: ["Computer Science"],
        languagesRequired: ["English", "Arabic"],
        jobDescription: "We are looking for a Senior Flutter Developer to join our mobile development team. You will be responsible for developing cross-platform mobile applications using Flutter framework.",
        postUrl: "https://www.linkedin.com/jobs/view/3456789012",
        hrEmail: "hr@techcorp.com",
      ),
      const LinkedinPostEntity(
        jobTitle: "Backend Developer",
        companyName: "StartupXYZ",
        requiredSkills: ["Node.js", "MongoDB", "Express", "Docker"],
        preferredSkills: ["AWS", "Kubernetes"],
        experienceYears: "2+ years",
        educationRequired: null,
        languagesRequired: ["English"],
        jobDescription: "Join our fast-growing startup as a Backend Developer. You'll work on scalable APIs and microservices that power our platform used by thousands of users.",
        postUrl: "https://www.linkedin.com/jobs/view/3456789013",
        hrEmail: "jobs@startupxyz.com",
      ),
    ];
    
    emit(
      state.copyWith(
        isLoadingLinkedinPosts: false,
        linkedinPostsList: mockPosts,
      ),
    );
    
    // Original API call code (commented out)
    /*
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
    */
  }
}
