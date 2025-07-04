import 'package:ecowin/Controllers/cubit/Ui_Cubits/Onboarding_View_Cubit/onboarding_view_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Auth_Views/SignIn_Views/login_screen.dart';
import 'package:ecowin/Views/OnBoarding_Views/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbBoardingView extends StatelessWidget {
  const OnbBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Themeconstants.backgroundimage,
        BlocProvider(
          create: (context) => OnboardingViewCubit(),
          child: BlocConsumer<OnboardingViewCubit, OnboardingViewState>(
            listener: (context, state) {
              if (state is OnboardingViewDone) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            builder: (context, state) {
              final onBoardingCubit = context.read<OnboardingViewCubit>();
              final pageController = onBoardingCubit.pageController;
              final islastpage = onBoardingCubit.islastpage;
              return SafeArea(
                child: Container(
                  margin: REdgeInsets.all(15),
                  width: 4.sw,
                  height: 4.sh,
                  child: Column(children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: SwapEffect(
                          activeDotColor: AppColors.mainColor,
                          dotColor: Colors.grey,
                          dotHeight: 0.015.sh,
                          dotWidth: 0.25.sw,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      margin: REdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Image.asset(
                          "images/Logo.png",
                          width: 90.w,
                          height: 90.h,
                          fit: BoxFit.cover,
                        ),
                        Spacer(),
                        Visibility(
                          visible: !islastpage,
                          child: Container(
                            height: 42.h,
                            width: 65.w,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  overlayColor: Colors.transparent,
                                  side: BorderSide(
                                      color: AppColors.borderColor, width: 2),
                                  padding: REdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)).r,
                                  ),
                                ),
                                onPressed: () {
                                  onBoardingCubit.skipOnboarding();
                                },
                                child: Text("Skip",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "AirbnbCereal_W_Md"))),
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                        child: PageView(
                      onPageChanged: onBoardingCubit.onPageChanged,
                      controller: pageController,
                      children: [
                        OnboardingContent(
                            image: "images/onboarding1.png",
                            title: "Welcome to \n ECOWIN",
                            subtitle:
                                "Together, let's keep our environment clean by recycling waste responsibly."),
                        OnboardingContent(
                            image: "images/onboarding2.png",
                            title: "Easy Pickup",
                            subtitle:
                                "Schedule a waste pickup from your \n home or find a nearby drop-off spot."),
                        OnboardingContent(
                            image: "images/onboarding3.png",
                            title: "Earn \n Rewards",
                            subtitle:
                                "Recycle and earn points that you can \n redeem for rewards.")
                      ],
                    )),
                    GeneralButton(
                        text: islastpage ? "Get Started" : "Next",
                        tap: () {
                          islastpage
                              ? onBoardingCubit.skipOnboarding()
                              : onBoardingCubit.nextPage();
                        },
                        hnumber: 0.06.sh,
                        wnumber: 0.8.sw,
                        color: AppColors.mainColor,
                        textColor: Colors.white)
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
