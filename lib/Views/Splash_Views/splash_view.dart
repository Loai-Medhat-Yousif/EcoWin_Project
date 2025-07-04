import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Splash_View_Cubit/splash_view_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Views/Auth_Views/SignIn_Views/login_screen.dart';
import 'package:ecowin/Views/Home_Views/home_view.dart';
import 'package:ecowin/Views/OnBoarding_Views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => SplashViewCubitCubit()..navigation(),
        child: BlocListener<SplashViewCubitCubit, SplashViewCubitState>(
          listener: (context, state) async {
            if (state is SplashViewCubitOnBoard) {
              await Future.delayed(3.seconds);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const OnbBoardingView()),
              );
            } else if (state is SplashViewCubitAuthPage) {
              await Future.delayed(3.seconds);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            } else if (state is SplashViewCubitHome) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => HomeView()),
              );
            } else if (state is SplashViewCubitError) {
              ScreenDialogs.showFailureDialog(
                context,
                state.errormessage,
                "Ok",
                () {
                  context.read<SplashViewCubitCubit>().navigation();
                },
              );
            }
          },
          child: Stack(children: [
            Container(
              width: 4.sw,
              height: 4.sh,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Startup.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                "images/Logo.png",
                width: 700.w,
                height: 700.h,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .fade(duration: 1.5.seconds, begin: 0.4, end: 1.0),
            )
          ]),
        ),
      ),
    );
  }
}
