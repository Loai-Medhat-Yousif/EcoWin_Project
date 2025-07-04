import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Views/Home_Views/home_view.dart';
import 'package:ecowin/api/Services/Auth_Services/SignIn_Service/signinservice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signin_view_state.dart';

class SigninViewCubit extends Cubit<SigninViewState> {
  SigninViewCubit() : super(SigninViewInitial());

  Future<void> login(
      BuildContext context, String email, String password) async {
    final bool isRemembered = (state as SigninViewInitial).isRemembered;
    emit(SigninViewLoading());
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp emailRegex = RegExp(emailPattern);
    RegExp passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$');

    if (email.isEmpty) {
      emit(SigninViewInitial());
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your email address',
        'Ok',
        () {},
      );
    } else if (!emailRegex.hasMatch(email)) {
      emit(SigninViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid email address', 'Ok', () {});
    } else if (password.isEmpty) {
      emit(SigninViewInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter your password', 'Ok', () {});
    } else if (!passwordRegex.hasMatch(password)) {
      emit(SigninViewInitial());
      ScreenDialogs.showWarningDialog(
          context,
          'Password must be at least 8 characters long and contain letters and numbers.',
          'Ok',
          () {});
    } else {
      try {
        await Signinservice().signIn(email, password);
        if (!isClosed) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isRemembered', isRemembered);
          ScreenDialogs.showSuccessDialog(
              context, 'You have successfully logged in', 'Ok', () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(
                        )));
          });
          emit(SigninViewInitial());
        }
      } catch (e) {
        if (!isClosed) {
          ScreenDialogs.showFailureDialog(context, "$e", 'Try Again', () {
            emit(SigninViewInitial());
          });
        }
      }
    }
  }

  void toggleObscure() {
    if (state is SigninViewInitial) {
      final current = state as SigninViewInitial;
      emit(current.copyWith(isObscure: !current.isObscure));
    }
  }

  void toggleRememberMe() {
    if (state is SigninViewInitial) {
      final current = state as SigninViewInitial;
      emit(current.copyWith(isRemembered: !current.isRemembered));
    }
  }
}
