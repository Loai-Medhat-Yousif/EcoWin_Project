part of 'exchange_view_cubit.dart';

sealed class ExchangeViewState extends Equatable {
  const ExchangeViewState();

  @override
  List<Object> get props => [];
}

final class ExchangeViewInitial extends ExchangeViewState {}

final class ExchangeViewLoaded extends ExchangeViewState {
  final List<ProductModel> exchanges;
  final bool hasMore;
  final List<CategoryModel> categories;

  const ExchangeViewLoaded(this.exchanges, this.hasMore, this.categories);

  @override
  List<Object> get props => [exchanges, hasMore, categories];
}

final class ExchangeViewError extends ExchangeViewState {
  final String errorMessage;

  const ExchangeViewError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
