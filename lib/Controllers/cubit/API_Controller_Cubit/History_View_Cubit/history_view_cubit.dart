import 'package:ecowin/Models/Transation%20Models/transaction_model.dart';
import 'package:ecowin/api/Services/History_Services/history_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_view_state.dart';

class HistoryViewCubit extends Cubit<HistoryViewState> {
  int page = 1;

  HistoryViewCubit() : super(HistoryViewInitial());

  Future<void> fetchtransactions() async {
    emit(HistoryViewLoading());
    try {
      page = 1;
      final transactions = await HistoryService().fetchTransactions(page);
      if (transactions.length < 10) {
        if (!isClosed) emit(HistoryViewLoaded(transactions, false));
        return;
      }

      if (transactions.isEmpty) {
        emit(HistoryViewEmpty());
        return;
      }
      final hasMore = transactions.isNotEmpty;
      if (!isClosed) emit(HistoryViewLoaded(transactions, hasMore));
    } catch (e) {
      if (!isClosed) {
        emit(HistoryViewError("There was an Error Getting transactions."));
      }
    }
    return null;
  }

  Future<void> fetchMoretransactions() async {
    if (state is HistoryViewLoaded) {
      final currentState = state as HistoryViewLoaded;
      if (!currentState.hasMore) return;
      try {
        page++;
        final List<TransactionModel> newTransactions =
            await HistoryService().fetchTransactions(page);

        final allTransactions = [
          ...currentState.transactions,
          ...newTransactions,
        ];
        final hasMore = newTransactions.isNotEmpty;

        if (!isClosed) {
          emit(HistoryViewLoaded(allTransactions, hasMore));
        }
      } catch (e) {
        print(e);
        if (!isClosed) {
          emit(HistoryViewLoaded(
              (state as HistoryViewLoaded).transactions, false));
        }
      }
    }
  }
}
