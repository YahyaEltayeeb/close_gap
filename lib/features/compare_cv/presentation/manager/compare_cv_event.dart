import 'package:close_gap/features/get_linkedin_posts/domain/entities/linkedin_post_entity.dart';

sealed class CompareCvEvent {}

class SubmitCompareCvEvent extends CompareCvEvent {
  final LinkedinPostEntity post;
  SubmitCompareCvEvent(this.post);
}
