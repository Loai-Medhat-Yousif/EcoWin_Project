part of 'profile_data_cubit.dart';

abstract class ProfileDataState {}

class ProfileDataInitial extends ProfileDataState {}

class ProfileDataLoading extends ProfileDataState {}

class ProfileDataLoaded extends ProfileDataState {
  final ProfileDataModel profile;
  final List<LeaderboardDataModel> leaderboard;

  ProfileDataLoaded(this.profile, this.leaderboard);
}

class ProfileDataError extends ProfileDataState {
  final String message;

  ProfileDataError(this.message);
}
