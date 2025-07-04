import 'dart:io' show Platform, exit;
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Exchange_View_Cubit/exchange_view_cubit.dart';
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Profile_Data_Cubit/profile_data_cubit.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SliderDrawerState> sliderDrawerKey =
        GlobalKey<SliderDrawerState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ProfileDataCubit()..loadProfile()),
      ],
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
        child: BlocBuilder<ProfileDataCubit, ProfileDataState>(
          builder: (context, state) {
            if (state is ProfileDataLoading) {
              return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                )),
              );
            } else if (state is ProfileDataLoaded) {
              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  return SliderDrawer(
                    key: sliderDrawerKey,
                    appBar: AppBar(),
                    isDraggable: true,
                    sliderOpenSize: 0.5.sw,
                    slider: SliderItems(
                      sliderDrawerKey: sliderDrawerKey,
                      profile: state.profile,
                      leaderboard: state.leaderboard,
                    ),
                    child: Scaffold(
                      body: Stack(
                        children: [
                          Themeconstants.backgroundimage,
                          PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller:
                                context.read<HomeCubit>().pageController,
                            children: [
                              HomeViewBody(
                                profile: state.profile,
                                leaderboard: state.leaderboard,
                                sliderDrawerKey: sliderDrawerKey,
                              ),
                              const RewardView(),
                              BlocProvider(
                                create: (context) =>
                                    ExchangeViewCubit()..loadInitialData(),
                                child: const ExchangeView(),
                              ),
                              ProfileView(profile: state.profile),
                            ],
                          )
                        ],
                      ),
                      resizeToAvoidBottomInset: true,
                      bottomNavigationBar: generalBottomAppBar(
                        selectedIndex: homeState.selectedIndex,
                        onItemTapped: (index) =>
                            context.read<HomeCubit>().changeIndex(index),
                      ),
                      floatingActionButton: SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: FloatingActionButton(
                          heroTag: 'exchange-fab',
                          elevation: 3,
                          onPressed: () {
                            // Scan logic
                          },
                          backgroundColor: AppColors.mainColor,
                          shape: const CircleBorder(),
                          child: Icon(Icons.camera,
                              color: Colors.white, size: 35.sp),
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                    ),
                  );
                },
              );
            } else if (state is ProfileDataError) {
              return Scaffold(
                body: Center(
                    child: GestureDetector(
                        onTap: () =>
                            context.read<ProfileDataCubit>().loadProfile(),
                        child: Text("Error: ${state.message} , Try Again ?"))),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
