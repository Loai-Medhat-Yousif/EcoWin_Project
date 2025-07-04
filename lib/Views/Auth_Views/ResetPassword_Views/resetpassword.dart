import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/ResetPassword_View_Cubit/resetpassword_view_cubit.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Auth_Views/ResetPassword_Views/Widgets/resetpassword_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Themeconstants.backgroundimage,
        Positioned(
          child: SafeArea(
            child: GeneralAppBar(
              backbutton: true,
              title: " ",
              ontap: () => Navigator.pop(context),
              itemscolor: Colors.black,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: REdgeInsets.only(top: 0.1.sh),
            child: BlocProvider(
              create: (context) => ResetpasswordViewCubit(),
              child:
                  BlocBuilder<ResetpasswordViewCubit, ResetpasswordViewState>(
                builder: (context, state) {
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller:
                        context.read<ResetpasswordViewCubit>().pageController,
                    children: [
                      ResetpasswordPageView(
                          image: "images/illustration.png",
                          title: "Reset Password",
                          subtitle:
                              "Please enter your email address to\nrequest a password reset."),
                      ResetpasswordPageView(
                          image: "images/Envlope.png",
                          title: "Check Your Email",
                          subtitle: "We’ve sent an OTP code to your email"),
                      ResetpasswordPageView(
                          image: "images/Password.png",
                          title: "Create New Password",
                          subtitle:
                              "Use at least 8 characters,\nincluding letters and numbers."),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
