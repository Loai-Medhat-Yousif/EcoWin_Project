// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:ecowin/Views/About_Us_Views/about_us_view.dart';
import 'package:ecowin/Views/Ai_Scanner_Views/ai_scanner_view.dart';
import 'package:ecowin/Views/Charity_Views/charity_view.dart';
import 'package:ecowin/Views/Green_Guide_Views/green_guide_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:ecowin/Controllers/cubit/Ui_Cubits/Home_View_Cubit/home_view_cubit_cubit.dart';
import 'package:ecowin/Core/Constants/general_listtile.dart';
import 'package:ecowin/Views/Auth_Views/SignIn_Views/login_screen.dart';
import 'package:ecowin/Views/Leader_Board_Views/leaderboard_view.dart';
import 'package:ecowin/Views/Rewards_Views/my_coupons_view.dart';

class SliderItems extends StatelessWidget {
  SliderItems({
    Key? key,
    required this.profile,
    required this.leaderboard,
    required this.sliderDrawerKey,
  }) : super(key: key);

  final ProfileDataModel profile;
  final List<LeaderboardDataModel> leaderboard;
  final GlobalKey<SliderDrawerState> sliderDrawerKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.verticalSpace,
          ListTile(
              contentPadding: REdgeInsets.only(
                left: 15,
                top: 10,
                bottom: 10,
              ),
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: profile.image,
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )),
          ListTile(
            contentPadding: REdgeInsets.only(left: 15, top: 10, bottom: 10),
            title: Text(
              profile.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: "AirbnbCereal_W_Bd",
              ),
            ),
          ),
          GeneralListtile(
              listtitle: "My Profile",
              icon: Icons.person_outline,
              tap: () {
                sliderDrawerKey.currentState?.closeSlider();
                context.read<HomeCubit>().changeIndex(3);
              }),
          GeneralListtile(
              listtitle: "My Coupons",
              icon: Icons.redeem,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MyCouponsView(),
                  ),
                );
              }),
          GeneralListtile(
              listtitle: "Leaderboard",
              icon: Icons.leaderboard_outlined,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LeaderboardView(
                      leaderboard: leaderboard,
                    ),
                  ),
                );
              }),
          GeneralListtile(
              listtitle: "AI Assistant",
              icon: Icons.camera,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ScannerView(),
                  ),
                );
              }),
          GeneralListtile(
              listtitle: "Charity",
              icon: Icons.handshake_outlined,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CharityView(),
                  ),
                );
              }),
          GeneralListtile(
              listtitle: "Green Guide",
              icon: Icons.question_answer_outlined,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const GreenGuideView(),
                  ),
                );
              }),
          GeneralListtile(
              listtitle: "About Us",
              icon: Icons.info,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AboutUsView(),
                  ),
                );
              }),
          ListTile(
            horizontalTitleGap: 0.004.sh,
            minTileHeight: 0.01.sh,
            contentPadding: REdgeInsets.only(left: 15, top: 10, bottom: 10),
            leading:
                Icon(Icons.logout_outlined, color: Colors.red, size: 20.sp),
            title: Text("Log Out",
                style: TextStyle(
                  fontFamily: "AirbnbCereal_W_Md",
                  fontSize: 12.sp,
                )),
            onTap: () async {
              await context.read<HomeCubit>().logout(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
    );
  }
}
