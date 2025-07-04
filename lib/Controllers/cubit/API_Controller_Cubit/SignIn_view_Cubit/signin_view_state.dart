part of 'signin_view_cubit.dart';

sealed class SigninViewState extends Equatable {
  const SigninViewState();

  @override
  List<Object> get props => [];
}

final class SigninViewInitial extends SigninViewState {
  final bool isRemembered;
  final bool isObscure;
  const SigninViewInitial({
    this.isRemembered = true,
    this.isObscure = true,
  });

  SigninViewState copyWith({
    bool? isRemembered,
    bool? isObscure,
    String? errorMessage,
  }) {
    return SigninViewInitial(
      isRemembered: isRemembered ?? this.isRemembered,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object> get props => [isRemembered, isObscure];
}

final class SigninViewLoading extends SigninViewState {}
