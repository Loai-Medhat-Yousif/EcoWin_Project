import 'package:ecowin/Views/Home_Views/Widget/home_view_card.dart';
import 'package:ecowin/Views/Home_Views/Widget/leaderboard_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:ecowin/Controllers/cubit/Ui_Cubits/Home_View_Cubit/home_view_cubit_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';

class HomeViewBody extends StatelessWidget {
  final ProfileDataModel profile;
  final List<LeaderboardDataModel> leaderboard;
  final GlobalKey<SliderDrawerState> sliderDrawerKey;
  const HomeViewBody({
    Key? key,
    required this.profile,
    required this.leaderboard,
    required this.sliderDrawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.isDrawerOpen != current.isDrawerOpen,
      listener: (context, state) {
        if (state.isDrawerOpen) {
          sliderDrawerKey.currentState?.openSlider();
        } else {
          sliderDrawerKey.currentState?.closeSlider();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
                child: Container(
              height: 0.3.sh,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40).r,
                  bottomRight: Radius.circular(40).r,
                ),
              ),
            )),
            Positioned(
              top: 0.05.sh,
              left: 0.05.sw,
              child: IconButton(
                  onPressed: () {
                    if (sliderDrawerKey.currentState!.isDrawerOpen) {
                      sliderDrawerKey.currentState?.closeSlider();
                    } else {
                      sliderDrawerKey.currentState?.openSlider();
                    }
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40.sp,
                  )),
            ),
            Positioned(
              top: 0.12.sh,
              left: 0.07.sw,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: "AirbnbCereal_W_bd"),
                    "Welcome Back \n ${profile.name} !!"),
              ),
            ),
            Positioned(
                top: 0.2.sh,
                left: 0,
                right: 0,
                child: HomeViewCard(
                  points: profile.points,
                )),
            Positioned(
                top: 0.42.sh,
                left: 0.05.sw,
                child: Text(
                  "Our Leader board",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontFamily: "AirbnbCereal_W_bd"),
                )),
            Positioned(
              top: 0.47.sh,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                padding: REdgeInsets.only(top: 5),
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  return LeaderboardListView(
                    index: index,
                    image: leaderboard[index].image,
                    name: leaderboard[index].name,
                    points: leaderboard[index].points,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
