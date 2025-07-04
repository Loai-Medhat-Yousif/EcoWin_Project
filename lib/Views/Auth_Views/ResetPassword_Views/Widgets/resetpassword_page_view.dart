import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/ResetPassword_View_Cubit/resetpassword_view_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Constants/general_textfield.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class ResetpasswordPageView extends StatefulWidget {
  ResetpasswordPageView({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  State<ResetpasswordPageView> createState() => _ResetpasswordPageViewState();
}

class _ResetpasswordPageViewState extends State<ResetpasswordPageView> {
  final TextEditingController verifyEmailController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController newPasswordConfirmController =
      TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(right: 8, left: 8, bottom: 35),
      child: BlocBuilder<ResetpasswordViewCubit, ResetpasswordViewState>(
        builder: (context, state) {
          return (state is ResetpasswordViewLoading)
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: 150.h,
                            width: 150.w,
                            widget.image,
                            fit: BoxFit.contain,
                          ),
                          15.verticalSpace,
                          Container(
                            margin: REdgeInsets.symmetric(horizontal: 5),
                            width: double.infinity,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'AirbnbCereal_W_Md',
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          Container(
                            margin: REdgeInsets.symmetric(horizontal: 5),
                            width: double.infinity,
                            child: Text(
                              widget.subtitle,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'AirbnbCereal_W_Lt',
                                fontSize: 15.sp,
                                letterSpacing: 1.2,
                                height: 1.2,
                              ),
                            ),
                          ),
                          if (widget.title == "Reset Password") ...[
                            GeneralTextfield(
                                fieldcontroller: verifyEmailController,
                                fieldHintText: "Your Email Address",
                                icon: Icons.email_outlined),
                            20.verticalSpace,
                            GeneralButton(
                                text: "Next",
                                tap: () {
                                  context
                                      .read<ResetpasswordViewCubit>()
                                      .validateEmail(
                                        context,
                                        verifyEmailController.text,
                                      );
                                },
                                hnumber: 0.055.sh,
                                wnumber: 0.6.sw,
                                color: AppColors.mainColor,
                                textColor: Colors.white),
                          ],
                          if (widget.title == "Check Your Email") ...[
                            15.verticalSpace,
                            Container(
                              margin: REdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              child: Text(
                                "${context.read<ResetpasswordViewCubit>().email}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'AirbnbCereal_W_Lt',
                                  fontSize: 16.sp,
                                  letterSpacing: 1.2,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            15.verticalSpace,
                            Pinput(
                              length: 6,
                              controller: _otpController,
                              defaultPinTheme: PinTheme(
                                width: 50.w,
                                height: 50.h,
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25).r,
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 55.w,
                                height: 55.h,
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              showCursor: true,
                              keyboardType: TextInputType.number,
                              preFilledWidget: Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            20.verticalSpace,
                            Container(
                              margin: REdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't receive the code? Resend in ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'AirbnbCereal_W_Lt',
                                        fontSize: 12.sp,
                                        letterSpacing: 1.2,
                                        height: 1.2,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ResetpasswordViewCubit>()
                                            .resendOtp(
                                              context,
                                              context
                                                  .read<
                                                      ResetpasswordViewCubit>()
                                                  .email,
                                            );
                                        _otpController.clear();
                                      },
                                      child: Text(
                                        context
                                                    .read<
                                                        ResetpasswordViewCubit>()
                                                    .secondsRemaining ==
                                                0
                                            ? "Resend"
                                            : context
                                                .read<ResetpasswordViewCubit>()
                                                .formatTime(context
                                                    .read<
                                                        ResetpasswordViewCubit>()
                                                    .secondsRemaining),
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontFamily: 'AirbnbCereal_W_Lt',
                                          fontSize: 12.sp,
                                          letterSpacing: 1.2,
                                          height: 1.2,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            20.verticalSpace,
                            GeneralButton(
                                text: "Next",
                                tap: () {
                                  context
                                      .read<ResetpasswordViewCubit>()
                                      .validateOTP(
                                        context,
                                        verifyEmailController.text,
                                        _otpController.text,
                                      );
                                },
                                hnumber: 0.055.sh,
                                wnumber: 0.6.sw,
                                color: AppColors.mainColor,
                                textColor: Colors.white),
                          ],
                          if (widget.title == "Create New Password") ...[
                            GeneralTextfield(
                                fieldcontroller: newPasswordController,
                                fieldHintText: "Your New Password",
                                icon: Icons.lock_outline),
                            GeneralTextfield(
                                fieldcontroller: newPasswordConfirmController,
                                fieldHintText: "Confirm Password",
                                icon: Icons.lock_outline),
                            20.verticalSpace,
                            GeneralButton(
                                text: "Confirm",
                                tap: () {
                                  context
                                      .read<ResetpasswordViewCubit>()
                                      .newPassword(
                                        context,
                                        verifyEmailController.text,
                                        newPasswordController.text,
                                        newPasswordConfirmController.text,
                                      );
                                },
                                hnumber: 0.055.sh,
                                wnumber: 0.6.sw,
                                color: AppColors.mainColor,
                                textColor: Colors.white),
                          ],
                        ]),
                  ),
                );
        },
      ),
    );
  }
}
