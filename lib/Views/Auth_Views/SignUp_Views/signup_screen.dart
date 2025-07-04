import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Signup_View_Cubit/signup_view_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Constants/general_textfield.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController confirmpasswordcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => SignupViewCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          Themeconstants.backgroundimage,
          Positioned(
            child: SafeArea(
              child: GeneralAppBar(
                title: "",
                backbutton: true,
                ontap: () => Navigator.pop(context),
                itemscolor: Colors.black,
              ),
            ),
          ),
          BlocBuilder<SignupViewCubit, SignupViewState>(
            builder: (context, state) {
              return (state is SignupViewLoading)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    )
                  : Container(
                      margin: REdgeInsets.only(top: 60, bottom: 20),
                      child: Center(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: REdgeInsets.only(
                                  top: 10,
                                  left: 15,
                                  right: 15,
                                ),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'AirbnbCereal_W_Md'),
                                ),
                              ),
                              GeneralTextfield(
                                fieldcontroller: namecontroller,
                                fieldHintText: "name",
                                icon: Icons.person,
                              ),
                              GeneralTextfield(
                                fieldcontroller: emailController,
                                fieldHintText: "Email",
                                icon: Icons.email,
                              ),
                              GeneralTextfield(
                                fieldcontroller: phoneNumberController,
                                fieldHintText: "Phone Number",
                                icon: Icons.phone,
                              ),
                              GeneralTextfield(
                                fieldcontroller: passwordcontroller,
                                fieldHintText: "Password",
                                icon: Icons.lock,
                              ),
                              GeneralTextfield(
                                fieldcontroller: confirmpasswordcontroller,
                                fieldHintText: "Confirm Password",
                                icon: Icons.lock,
                              ),
                              15.verticalSpace,
                              GeneralButton(
                                  text: "Sign Up",
                                  tap: () {
                                    BlocProvider.of<SignupViewCubit>(context)
                                        .signup(
                                      context,
                                      emailController.text,
                                      passwordcontroller.text,
                                      confirmpasswordcontroller.text,
                                      phoneNumberController.text,
                                      namecontroller.text,
                                    );
                                  },
                                  hnumber: 0.05.sh,
                                  wnumber: 0.5.sw,
                                  color: AppColors.mainColor,
                                  textColor: Colors.white),
                              Container(
                                margin: REdgeInsets.only(top: 15),
                                child: RichText(
                                    text: TextSpan(
                                        text: "Already have an account ?  ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontFamily: "AirbnbCereal_W_Lt",
                                        ),
                                        children: [
                                      TextSpan(
                                        text: "Sign In",
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.sp,
                                          fontFamily: "AirbnbCereal_W_Md",
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context);
                                          },
                                      )
                                    ])),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
            },
          )
        ]),
      ),
    );
  }
}
