part of 'splash_view_cubit.dart';

sealed class SplashViewCubitState extends Equatable {
  const SplashViewCubitState();

  @override
  List<Object> get props => [];
}

final class SplashViewCubitInitial extends SplashViewCubitState {}

final class SplashViewCubitOnBoard extends SplashViewCubitState {}

final class SplashViewCubitAuthPage extends SplashViewCubitState {}

final class SplashViewCubitHome extends SplashViewCubitState {
  final ProfileDataModel profileData;

  final List<LeaderboardDataModel> leaderboardData;

  SplashViewCubitHome(
      {required this.profileData, required this.leaderboardData});
}

final class SplashViewCubitError extends SplashViewCubitState {
  final String errormessage;
  SplashViewCubitError(this.errormessage);
}
