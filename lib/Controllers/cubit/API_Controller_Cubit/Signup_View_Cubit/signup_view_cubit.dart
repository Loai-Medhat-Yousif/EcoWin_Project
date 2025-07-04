import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:ecowin/Views/Home_Views/home_view.dart';
import 'package:ecowin/api/Services/Auth_Services/SignUp_Service/signupservice.dart';
import 'package:ecowin/api/Services/LeaderBoard_Service/leaderboard_service.dart';
import 'package:ecowin/api/Services/Profile%20Service/profile_data_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_view_state.dart';

class SignupViewCubit extends Cubit<SignupViewState> {
  SignupViewCubit() : super(SignupViewInitial());

  Future<void> signup(BuildContext context, String email, String password,
      String confirmpassword, String phone, String name) async {
    emit(SignupViewLoading());
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp emailRegex = RegExp(emailPattern);
    RegExp passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$');
    RegExp phoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');

    if (name.isEmpty) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your full name',
        'Ok',
        () {},
      );
    } else if (!emailRegex.hasMatch(email)) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid email address', 'Ok', () {});
    } else if (phone.isEmpty) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your phone number',
        'Ok',
        () {},
      );
    } else if (!phoneRegex.hasMatch(phone)) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid phone number', 'Ok', () {});
    } else if (password.isEmpty) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter your password', 'Ok', () {});
    } else if (!passwordRegex.hasMatch(password)) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context,
          'Password must be at least 8 characters long and contain letters and numbers.',
          'Ok',
          () {});
    } else if (confirmpassword.isEmpty) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please confirm your password', 'Ok', () {});
    } else if (password != confirmpassword) {
      emit(SignupViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Passwords do not match', 'Ok', () {});
    } else {
      try {
        await Signupservice()
            .signUp(name, email, phone, password, confirmpassword);
        if (!isClosed) {
          final ProfileDataModel profileData =
              await ProfileDataService().fetchProfileData();
          final List<LeaderboardDataModel> leaderboardData =
              await LeaderboardService().fetchLeaderboardData();
          ScreenDialogs.showSuccessDialog(
              context, 'You have successfully logged in', 'Ok', () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isRemembered', true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(
                          profile: profileData,
                          leaderboard: leaderboardData,
                        )));
          });
        }
      } catch (e) {
        if (!isClosed) {
          ScreenDialogs.showFailureDialog(
              context, "There Was An Error While Signing Up", 'Ok', () {
            emit(SignupViewInitial());
          });
        }
      }
    }
  }
}
