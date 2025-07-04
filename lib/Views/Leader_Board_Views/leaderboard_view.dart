import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Leader_Board_Views/Widgets/leaderboard_card.dart';
import 'package:ecowin/Views/Leader_Board_Views/Widgets/other_user_leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecowin/Models/Profile%20Models/leaderboard_data_model.dart';

class LeaderboardView extends StatelessWidget {
  final List<LeaderboardDataModel> leaderboard;
  LeaderboardView({
    Key? key,
    required this.leaderboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Themeconstants.backgroundimage,
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 10),
                child: GeneralAppBar(
                  backbutton: true,
                  title: "Leaderboard",
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  itemscolor: Colors.black,
                ),
              ),
              Image.asset(
                "images/Crown.png",
                height: 45.h,
                width: 45.w,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LeaderBoardRow(
                    rankAsset: "images/Rank2.png",
                    image: leaderboard[1].image,
                    name: leaderboard[1].name,
                    points: leaderboard[1].points.toString(),
                    heightBox: 130.h,
                    avatarSize: 50.r,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                    ),
                    pointColor: Color(0xff00B9FF),
                  ),
                  LeaderBoardRow(
                    rankAsset: "images/Rank1.png",
                    image: leaderboard[0].image,
                    name: leaderboard[0].name,
                    points: leaderboard[0].points.toString(),
                    heightBox: 180.h,
                    avatarSize: 50.r,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    pointColor: Color(0xffFFC801),
                  ),
                  LeaderBoardRow(
                    rankAsset: "images/Rank3.png",
                    image: leaderboard[2].image,
                    name: leaderboard[2].name,
                    points: leaderboard[2].points.toString(),
                    heightBox: 130.h,
                    avatarSize: 50.r,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                    ),
                    pointColor: Color(0xff00D95F),
                  ),
                ],
              ),
              20.verticalSpace,
              Expanded(
                child: ListView.builder(
                  padding: REdgeInsets.only(top: 5),
                  itemCount: leaderboard.length - 3,
                  itemBuilder: (context, index) {
                    return OtherUserLeaderboard(
                      index: index + 3,
                      image: leaderboard[index + 3].image,
                      name: leaderboard[index + 3].name,
                      points: leaderboard[index + 3].points,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
