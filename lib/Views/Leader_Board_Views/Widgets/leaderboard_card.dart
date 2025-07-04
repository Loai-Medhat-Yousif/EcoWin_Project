import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecowin/Core/Theme/colors.dart';

Widget LeaderBoardRow({
  required String rankAsset,
  required String image,
  required String name,
  required String points,
  required double heightBox,
  required double avatarSize,
  required BorderRadius borderRadius,
  required Color pointColor,
}) {
  return Container(
    height: heightBox + 100.h,
    width: 100.w,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: heightBox,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: borderRadius,
          ),
        ),
        Positioned(
          bottom: heightBox - 20.h,
          child: CircleAvatar(
            radius: avatarSize + 5.r,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: avatarSize,
              backgroundImage: NetworkImage(image),
            ),
          ),
        ),
        Positioned(
          bottom: heightBox - 45.h,
          child: Image.asset(
            rankAsset,
            height: 45.h,
            width: 45.w,
          ),
        ),
        Positioned(
          bottom: 40.h,
          child: SizedBox(
            width: 100.w,
            child: Text(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              name.split(' ').first,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.white,
                fontFamily: "AirbnbCereal_W_bd",
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15.h,
          child: Text(
            points,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: pointColor,
              fontFamily: "AirbnbCereal_W_bd",
            ),
          ),
        ),
      ],
    ),
  );
}
