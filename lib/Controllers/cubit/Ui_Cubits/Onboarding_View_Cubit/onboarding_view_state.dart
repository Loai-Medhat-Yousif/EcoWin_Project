part of 'onboarding_view_cubit.dart';

sealed class OnboardingViewState extends Equatable {
  const OnboardingViewState();

  @override
  List<Object> get props => [];
}

final class OnboardingViewControl extends OnboardingViewState {
  final bool isLastPage;

  const OnboardingViewControl({this.isLastPage = false});

  @override
  List<Object> get props => [isLastPage];
}


final class OnboardingViewDone extends OnboardingViewState {}
