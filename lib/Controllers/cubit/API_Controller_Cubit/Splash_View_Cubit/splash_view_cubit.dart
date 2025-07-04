import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:ecowin/api/Services/LeaderBoard_Service/leaderboard_service.dart';
import 'package:ecowin/api/Services/Profile%20Service/profile_data_service.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_view_state.dart';

class SplashViewCubitCubit extends Cubit<SplashViewCubitState> {
  SplashViewCubitCubit() : super(SplashViewCubitOnBoard());

  Future<void> navigation() async {
    emit(SplashViewCubitInitial());
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('ShowHome') ?? false;
    final isremembered = prefs.getBool('isRemembered') ?? false;

    if (hasSeenOnboarding == true && isremembered == true) {
      try {
        final ProfileDataModel profileData =
            await ProfileDataService().fetchProfileData();
        final List<LeaderboardDataModel> leaderboardData =
            await LeaderboardService().fetchLeaderboardData();
        emit(SplashViewCubitHome(
            profileData: profileData, leaderboardData: leaderboardData));
      } catch (e) {
        print(e);
        emit(SplashViewCubitError("There was an Error Getting Profile Data."));
      }
    } else if (hasSeenOnboarding == true && isremembered == false) {
      emit(SplashViewCubitAuthPage());
    } else {
      emit(SplashViewCubitOnBoard());
    }
  }
}
