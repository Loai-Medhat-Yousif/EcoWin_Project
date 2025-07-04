part of 'resetpassword_view_cubit.dart';

sealed class ResetpasswordViewState extends Equatable {
  const ResetpasswordViewState();

  @override
  List<Object> get props => [];
}

final class ResetpasswordViewInitial extends ResetpasswordViewState {}

final class ResetpasswordViewLoading extends ResetpasswordViewState {}

final class OtpTimerTicking extends ResetpasswordViewState {
  final int secondsRemaining;

  const OtpTimerTicking(this.secondsRemaining);

  @override
  List<Object> get props => [secondsRemaining];
}

final class OtpTimerFinished extends ResetpasswordViewState {}
