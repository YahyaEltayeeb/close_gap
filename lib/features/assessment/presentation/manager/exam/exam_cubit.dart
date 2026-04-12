import 'dart:async';
import 'package:close_gap/features/assessment/domain/entities/exam_answer_entity%20.dart';
import 'package:close_gap/features/assessment/data/model/request/start_exam_request.dart';
import 'package:close_gap/features/assessment/domain/entities/start_exam_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/network/api_results.dart';
import 'package:close_gap/features/assessment/domain/use_case/assessment_use_case.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_question_entity.dart';
import 'package:close_gap/features/assessment/domain/entities/exam_finish_entity.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_answer_request.dart';
import 'package:close_gap/features/assessment/data/model/request/exam_finish_request.dart';
import 'package:injectable/injectable.dart';

part 'exam_state.dart';

@Injectable()
class ExamCubit extends Cubit<ExamState> {
  final AssessmentUseCase _useCase;

  ExamCubit(this._useCase) : super(ExamInitial());

  Timer? _timer;

  List<QuestionEntity> _questions = [];
  Map<int, int> _answers = {};

  int _currentIndex = 0;
  int _remainingSeconds = 0;
  int? _examId;

  bool _isFinishing = false;

  Future<void> startExam({required int trackId}) async {
    emit(ExamLoading());

    _currentIndex = 0;
    _answers.clear();

    // ✅ Step 1: getStartExam عشان نجيب examId و remainingSeconds
    final startResult = await _useCase.getStartExam(
      StartExamRequest(trackId: trackId),
    );

    if (startResult is ApiErrorResult<StartExamEntity>) {
      emit(ExamError(startResult.failure.toString()));
      return;
    }

    final startData = (startResult as ApiSuccessResult<StartExamEntity>).data;
    _examId = startData.exam?.id;
    final remaining = startData.remainingSeconds ?? 0;
    _remainingSeconds = remaining <= 0 ? 1800 : remaining;

    // ✅ Step 2: getExamQuestions
    final questionsResult = await _useCase.getExamQuestions(
      track: 'Ai', // مؤقت
      level: 'basic',
      page: 1,
      perPage: 100,
    );

    if (questionsResult is ApiSuccessResult<ExamQuestionsEntity>) {
      _questions = questionsResult.data.questions ?? [];
      print('QUESTIONS COUNT: ${_questions.length}');
      _startTimer();
      emit(_buildLoaded());
    } else if (questionsResult is ApiErrorResult<ExamQuestionsEntity>) {
      emit(ExamError(questionsResult.failure.toString()));
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      _remainingSeconds--;

      if (_remainingSeconds <= 0) {
        await finishExam();
        return;
      }

      if (state is ExamLoaded) {
        emit(_buildLoaded());
      }
    });
  }

  Future<void> selectAnswer(int questionId, int optionId) async {
    if (_examId == null) return;

    _answers[questionId] = optionId;
    emit(_buildLoaded());

    final result = await _useCase.submitAnswer(
      ExamAnswerRequest(
        examId: _examId!,
        questionId: questionId,
        optionId: optionId,
      ),
    );

    if (result is ApiErrorResult<ExamAnswerEntity>) {
      emit(ExamError(result.failure.toString()));
    }
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      emit(_buildLoaded());
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      emit(_buildLoaded());
    }
  }

  Future<void> finishExam() async {
    if (_examId == null) return;
    if (_isFinishing) return;
    _isFinishing = true;

    _timer?.cancel();

    final result = await _useCase.finishExam(
      ExamFinishRequest(examId: _examId!),
    );

    _isFinishing = false;

    if (result is ApiSuccessResult<ExamFinishEntity>) {
      emit(ExamFinished(result.data));
    } else if (result is ApiErrorResult<ExamFinishEntity>) {
      emit(ExamError(result.failure.toString()));
    }
  }

  void forceFinishExam() {
    _timer?.cancel();
    emit(const ExamInvalidated());
  }

  ExamLoaded _buildLoaded() {
    return ExamLoaded(
      questions: _questions,
      currentIndex: _currentIndex,
      answers: _answers,
      remainingSeconds: _remainingSeconds,
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
