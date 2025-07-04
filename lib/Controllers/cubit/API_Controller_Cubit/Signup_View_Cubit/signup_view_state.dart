part of 'signup_view_cubit.dart';

sealed class SignupViewState extends Equatable {
  const SignupViewState();

  @override
  List<Object> get props => [];
}

final class SignupViewInitial extends SignupViewState {}

final class SignupViewLoading extends SignupViewState {}
