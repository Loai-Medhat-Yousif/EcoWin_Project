part of 'history_view_cubit.dart';

abstract class HistoryViewState extends Equatable {
  const HistoryViewState();

  @override
  List<Object> get props => [];
}

class HistoryViewInitial extends HistoryViewState {}

class HistoryViewLoading extends HistoryViewState {}

class HistoryViewLoaded extends HistoryViewState {
  final List<TransactionModel> transactions;
  final bool hasMore;

  const HistoryViewLoaded(this.transactions, this.hasMore);

  @override
  List<Object> get props => [transactions, hasMore];
}

class HistoryViewError extends HistoryViewState {
  final String message;

  const HistoryViewError(this.message);

  @override
  List<Object> get props => [message];
}
