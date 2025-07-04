import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/Q&A%20Models/q&a_model.dart';
import 'package:ecowin/api/Services/Green_Guide_Services/faq_service.dart';
import 'package:equatable/equatable.dart';
part 'questions_view_state.dart';

class FQAViewCubit extends Cubit<FAQViewState> {
  FQAViewCubit() : super(FAQViewInitial());

  int page = 1;
  int searchpage = 1;

  Future<void> fetchQuestions() async {
    try {
      final List<QuestionAndAnswerModel> questions =
          await QuestionAndAnswerService().fetchQuestions(page = 1);
      if (!isClosed) emit(FAQViewLoaded(questions, true));
      print(questions);
    } catch (e) {
      if (!isClosed)
        emit(FAQViewError("There was an Error Getting Questions."));
    }
  }

  Future<void> fetchMoreQuestions() async {
    try {
      final List<QuestionAndAnswerModel> morequestions =
          await QuestionAndAnswerService().fetchQuestions(page++);
      if (state is FAQViewLoaded) {
        final List<QuestionAndAnswerModel> updatedquestions = [
          ...(state as FAQViewLoaded).questions,
          ...morequestions
        ];
        final hasMore = morequestions.isNotEmpty;
        if (!isClosed) emit(FAQViewLoaded(updatedquestions, hasMore));
      }
    } catch (e) {
      if (state is FAQViewLoaded && !isClosed) {
        emit(FAQViewLoaded((state as FAQViewLoaded).questions, false));
      }
    }
  }

  Future<void> searchQuestions(String question) async {
    try {
      if (!isClosed) emit(FAQViewSearch());

      searchpage = 1;

      final List<QuestionAndAnswerModel> questions =
          await QuestionAndAnswerService()
              .searchQuestions(question, searchpage);

      if (questions.isEmpty) {
        if (!isClosed) {
          emit(FAQViewSearchError("No Questions Found for \"$question\""));
        }
        return;
      }

      final hasMore = questions.length >= 5;
      if (!isClosed) emit(FAQViewSearchLoaded(questions, hasMore));
    } catch (e) {
      if (!isClosed) {
        emit(FAQViewSearchError("There was an Error Getting Questions."));
      }
    }
  }

  Future<void> fetchMoreSearchedQuestions(String question) async {
    try {
      final List<QuestionAndAnswerModel> moreQuestions =
          await QuestionAndAnswerService()
              .searchQuestions(question, searchpage++);
      if (state is FAQViewSearchLoaded) {
        final List<QuestionAndAnswerModel> updatedquestions = [
          ...(state as FAQViewSearchLoaded).questions,
          ...moreQuestions
        ];
        final hasMore = moreQuestions.isNotEmpty;
        if (!isClosed) emit(FAQViewSearchLoaded(updatedquestions, hasMore));
      }
    } catch (e) {
      if (state is FAQViewSearchLoaded && !isClosed) {
        emit(FAQViewSearchLoaded(
            (state as FAQViewSearchLoaded).questions, false));
      }
    }
  }
}
