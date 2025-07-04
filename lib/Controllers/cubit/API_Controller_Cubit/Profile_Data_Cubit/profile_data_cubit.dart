import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:ecowin/api/Services/LeaderBoard_Service/leaderboard_service.dart';
import 'package:ecowin/api/Services/Profile%20Service/profile_data_service.dart';
part 'profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit() : super(ProfileDataInitial());

  Future<void> loadProfile() async {
    try {
      emit(ProfileDataLoading());
      final profile = await ProfileDataService().fetchProfileData();
      final leaderboard = await LeaderboardService().fetchLeaderboardData();
      emit(ProfileDataLoaded(profile, leaderboard));
    } catch (e) {
      emit(ProfileDataError(e.toString()));
    }
  }
}
