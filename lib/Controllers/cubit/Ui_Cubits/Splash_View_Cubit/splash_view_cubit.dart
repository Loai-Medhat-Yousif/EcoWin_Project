import 'package:bloc/bloc.dart';
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
        await Future.delayed(const Duration(seconds: 3));
        emit(SplashViewCubitHome());
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
