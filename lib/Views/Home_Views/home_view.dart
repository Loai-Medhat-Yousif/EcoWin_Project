import 'dart:io' show Platform, exit;
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Exchange_View_Cubit/exchange_view_cubit.dart';
import 'package:ecowin/Controllers/cubit/Ui_Cubits/Home_View_Cubit/home_view_cubit_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Exchange_Views/exchange_view.dart';
import 'package:ecowin/Views/Home_Views/Pages/home_view_body.dart';
import 'package:ecowin/Views/Home_Views/Widget/buttom_appbar.dart';
import 'package:ecowin/Views/Home_Views/Widget/slider_items.dart';
import 'package:ecowin/Views/Profile_Views/profile_view.dart';
import 'package:ecowin/Views/Rewards_Views/reward_view.dart';
import 'package:flutter/material.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeView extends StatelessWidget {
  final ProfileDataModel profile;
  final List<LeaderboardDataModel> leaderboard;
  const HomeView({
    Key? key,
    required this.profile,
    required this.leaderboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SliderDrawerState> sliderDrawerKey =
        GlobalKey<SliderDrawerState>();
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic _) async {
          ScreenDialogs.showOutDialog(context, "Exit App", "Exit", () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          });
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return SliderDrawer(
                key: sliderDrawerKey,
                appBar: AppBar(),
                isDraggable: true,
                sliderOpenSize: 0.5.sw,
                slider: SliderItems(
                    sliderDrawerKey: sliderDrawerKey,
                    profile: profile,
                    leaderboard: leaderboard),
                child: Scaffold(
                  body: Stack(children: [
                    Themeconstants.backgroundimage,
                    PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: context.read<HomeCubit>().pageController,
                        children: [
                          HomeViewBody(
                            profile: profile,
                            leaderboard: leaderboard,
                            sliderDrawerKey: sliderDrawerKey,
                          ),
                          RewardView(),
                          BlocProvider(
                            create: (context) => ExchangeViewCubit()..loadInitialData(),
                            child: ExchangeView(),
                          ),
                          ProfileView(
                            profile: profile,
                          ),
                        ])
                  ]),
                  resizeToAvoidBottomInset: true,
                  bottomNavigationBar: generalBottomAppBar(
                    selectedIndex: state.selectedIndex,
                    onItemTapped: (index) =>
                        context.read<HomeCubit>().changeIndex(index),
                  ),
                  floatingActionButton: SizedBox(
                    height: 70.h,
                    width: 70.w,
                    child: FloatingActionButton(
                      elevation: 3,
                      onPressed: () {},
                      backgroundColor: AppColors.mainColor,
                      shape: const CircleBorder(),
                      child:
                          Icon(Icons.camera, color: Colors.white, size: 35.sp),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                ));
          },
        ),
      ),
    );
  }
}
