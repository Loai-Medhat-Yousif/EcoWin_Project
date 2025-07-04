part of 'savedadresses_cubit.dart';

sealed class SavedadressesState extends Equatable {
  const SavedadressesState(this.savedadressescard);
  final List<Savedadressesmodel> savedadressescard;

  @override
  List<Object> get props => savedadressescard;
}

final class InitialAdressCardstate extends SavedadressesState {
  InitialAdressCardstate() : super([]);
}

final class UpdatedAdressCardState extends SavedadressesState {
  UpdatedAdressCardState(super.savedadressescard);
}

final class LoadingAdressCardState extends SavedadressesState {
  LoadingAdressCardState(super.savedadressescard);
}

final class ErrorAdressCardState extends SavedadressesState {
  final String message;
  ErrorAdressCardState(super.savedadressescard, this.message);
}

final class SucessfulAdressCardState extends SavedadressesState {
  SucessfulAdressCardState(super.savedadressescard);
}
