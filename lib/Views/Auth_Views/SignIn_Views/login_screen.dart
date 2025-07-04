import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/SignIn_view_Cubit/signin_view_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Constants/general_textfield.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Auth_Views/SignIn_Views/Widgets/signin_helper_row.dart';
import 'package:ecowin/Views/Auth_Views/SignUp_Views/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => SigninViewCubit(),
        child: Stack(children: [
          Themeconstants.backgroundimage,
          BlocBuilder<SigninViewCubit, SigninViewState>(
            builder: (context, state) {
              return (state is SigninViewLoading)
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
                            Container(
                              width: double.infinity,
                              child: Image.asset(
                                "images/Logo.png",
                                height: 150.h,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: REdgeInsets.only(left: 15),
                              child: Text(
                                textAlign: TextAlign.start,
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "AirbnbCereal_W_Md"),
                              ),
                            ),
                            GeneralTextfield(
                              fieldcontroller: emailController,
                              fieldHintText: "Email",
                              icon: Icons.email_outlined,
                            ),
                            Container(
                              margin: REdgeInsets.only(
                                  top: 20, left: 15, right: 15, bottom: 20),
                              child: TextField(
                                controller: passwordController,
                                cursorColor: AppColors.mainColor,
                                obscureText: state is SigninViewInitial
                                    ? state.isObscure
                                    : true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Padding(
                                    padding:
                                        REdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.lock_outlined,
                                      color: AppColors.secondaryColor,
                                      size: 25.sp,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xffe2e2e2),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Color(0xff8e8e93),
                                  ),
                                  suffixIcon: Padding(
                                    padding:
                                        REdgeInsets.symmetric(horizontal: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<SigninViewCubit>(
                                                context)
                                            .toggleObscure();
                                      },
                                      icon: Icon(
                                        state is SigninViewInitial &&
                                                state.isObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColors.secondaryColor,
                                        size: 25.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SigninHelperRow(
                              switchvalue: state is SigninViewInitial &&
                                  state.isRemembered,
                              switchonchange: (value) {
                                BlocProvider.of<SigninViewCubit>(context)
                                    .toggleRememberMe();
                              },
                            ),
                            GeneralButton(
                                text: "Sign in",
                                tap: () {
                                  BlocProvider.of<SigninViewCubit>(context)
                                      .login(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                },
                                hnumber: 0.05.sh,
                                wnumber: 0.5.sw,
                                color: AppColors.mainColor,
                                textColor: Colors.white),
                            Container(
                              margin: REdgeInsets.only(top: 20),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Don't have an account ?  ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontFamily: "AirbnbCereal_W_Lt",
                                      ),
                                      children: [
                                    TextSpan(
                                      text: "Sign up",
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontSize: 15.sp,
                                        fontFamily: "AirbnbCereal_W_Md",
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupScreen(),
                                            ),
                                          );
                                        },
                                    )
                                  ])),
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        ]),
      ),
    );
  }
}
