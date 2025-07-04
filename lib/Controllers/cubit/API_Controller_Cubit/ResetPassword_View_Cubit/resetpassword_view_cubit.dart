import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/api/Services/Auth_Services/ResetPassword_Service/reset_password_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'resetpassword_view_state.dart';

class ResetpasswordViewCubit extends Cubit<ResetpasswordViewState> {
  ResetpasswordViewCubit() : super(ResetpasswordViewInitial());

  PageController pageController = PageController(initialPage: 0);
  String email = '';
  Timer? _otpTimer;
  int _secondsRemaining = 90;

  int get secondsRemaining => _secondsRemaining;
  bool get canResend => _secondsRemaining == 0;

  Future<void> validateEmail(
    BuildContext context,
    String email,
  ) async {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp emailRegex = RegExp(emailPattern);

    if (email.isEmpty) {
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your email address',
        'Ok',
        () {},
      );
    } else if (!emailRegex.hasMatch(email)) {
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid email address', 'Ok', () {});
    } else {
      emit(ResetpasswordViewLoading());
      try {
        await ResetPasswordService().resetPassword(email);
        if (!isClosed) {
          startOtpTimer();
          this.email = email;
          nextPage();
          emit(ResetpasswordViewInitial());
        }
      } catch (e) {
        if (!isClosed) {
          ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
        }
      }
    }
  }

  Future<void> validateOTP(
      BuildContext context, String email, String otp) async {
    if (otp.isEmpty || otp.length != 6) {
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter a valid 6-digit OTP',
        'Ok',
        () {},
      );
      return;
    }
    emit(ResetpasswordViewLoading());
    try {
      await ResetPasswordService().verifyOtp(email, otp);
      if (!isClosed) {
        disposeTimer();
        nextPage();
        emit(ResetpasswordViewInitial());
      }
    } catch (e) {
      if (!isClosed) {
        ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
        emit(ResetpasswordViewInitial());
      }
    }
  }

  Future<void> newPassword(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
  ) async {
    RegExp passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$');

    if (password.isEmpty) {
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your New Password',
        'Ok',
        () {},
      );
    } else if (!passwordRegex.hasMatch(password)) {
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid password', 'Ok', () {});
    } else if (confirmPassword.isEmpty) {
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your Confirm Password',
        'Ok',
        () {},
      );
    } else if (password != confirmPassword) {
      ScreenDialogs.showWarningDialog(
          context, 'Password does not match', 'Ok', () {});
    } else {
      emit(ResetpasswordViewLoading());
      try {
        await ResetPasswordService()
            .newPassword(email, password, confirmPassword);
        if (!isClosed) {
          ScreenDialogs.showSuccessDialog(
              context, 'Password Reset Successfully', 'Ok', () {
            Navigator.pop(context);
          });
        }
      } catch (e) {
        if (!isClosed) {
          ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
        }
      }
    }
  }

  void startOtpTimer() {
    _secondsRemaining = 90;
    emit(OtpTimerTicking(_secondsRemaining));

    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isClosed && _secondsRemaining > 0) {
        _secondsRemaining--;
        emit(OtpTimerTicking(_secondsRemaining));
      } else if (!isClosed) {
        timer.cancel();
        emit(OtpTimerFinished());
      }
    });
  }

  Future<void> resendOtp(BuildContext context, String email) async {
    emit(ResetpasswordViewLoading());
    try {
      await ResetPasswordService().resetPassword(email);
      if (!isClosed) {
        _secondsRemaining = 90;
        emit(OtpTimerTicking(_secondsRemaining));
        startOtpTimer();
      }
    } catch (e) {
      if (!isClosed) {
        ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
      }
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void disposeTimer() {
    _otpTimer?.cancel();
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
