import 'package:json_annotation/json_annotation.dart';
part 'submission_exam_request.g.dart';


@JsonSerializable()
class SubmissionExamRequest {
    @JsonKey(name: "submission_id")
    int? submissionId;
    @JsonKey(name: "answers")
    List<Answer>? answers;

    SubmissionExamRequest({
        this.submissionId,
        this.answers,
    });

    factory SubmissionExamRequest.fromJson(Map<String, dynamic> json) => _$SubmissionExamRequestFromJson(json);

    Map<String, dynamic> toJson() => _$SubmissionExamRequestToJson(this);
}

@JsonSerializable()
class Answer {
    @JsonKey(name: "question_id")
    int? questionId;
    @JsonKey(name: "chosen_option_id")
    int? chosenOptionId;

    Answer({
        this.questionId,
        this.chosenOptionId,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

    Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
