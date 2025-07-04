part of 'questions_view_cubit.dart';

sealed class FAQViewState extends Equatable {
  const FAQViewState();

  @override
  List<Object> get props => [];
}

final class FAQViewInitial extends FAQViewState {
  const FAQViewInitial() : super();
}

final class FAQViewLoaded extends FAQViewState {
  final List<QuestionAndAnswerModel> questions;
  final bool hasMore;
  const FAQViewLoaded(
    this.questions,
    this.hasMore,
  );
  @override
  List<Object> get props => [questions, hasMore];
}

final class FAQViewError extends FAQViewState {
  final String errorMessage;
  const FAQViewError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class FAQViewSearch extends FAQViewState {
  const FAQViewSearch() : super();
}

final class FAQViewSearchError extends FAQViewState {
  final String errorMessage;
  const FAQViewSearchError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class FAQViewSearchLoaded extends FAQViewState {
  final List<QuestionAndAnswerModel> questions;
  final bool hasMore;
  const FAQViewSearchLoaded(
    this.questions,
    this.hasMore,
  );
  @override
  List<Object> get props => [questions, hasMore];
}
