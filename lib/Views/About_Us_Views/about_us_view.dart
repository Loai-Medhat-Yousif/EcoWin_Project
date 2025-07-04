import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/About_Us_Cubits/about_us_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutUsCubit()..fetchBrands(),
      child: Scaffold(
        body: Stack(children: [
          Themeconstants.backgroundimage,
          SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 10),
                child: GeneralAppBar(
                  backbutton: true,
                  title: "About Ecowin",
                  ontap: () {
                    Navigator.pop(context);
                  },
                  itemscolor: Colors.black,
                ),
              ),
              10.verticalSpace,
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "What is ECOWIN and how does it work?",
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontFamily: "AirbnbCereal_W_Md",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: REdgeInsets.only(left: 16, right: 16),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "ECOWIN is an application that makes recycling ",
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "Easier ",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "through AI-powered material detection, educational content, and a ",
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "rewarding system. \n",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "Users can recycle items, earn points, and redeem them for ",
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "vouchers, discounts. ",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "or make charity donations.",
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: "AirbnbCereal_W_Bk",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "Our Partners",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  10.verticalSpace,
                  BlocBuilder<AboutUsCubit, AboutUsState>(
                    builder: (context, state) {
                      if (state is AboutUsError) {
                        return Text(state.error);
                      } else if (state is AboutUsInitial) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ));
                      }
                      if (state is AboutUsLoaded)
                        return CarouselSlider(
                          items: state.brandImages.map((imageUrl) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 40.r,
                            );
                          }).toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 500),
                              enlargeCenterPage: true,
                              height: 100.h,
                              viewportFraction: 0.3,
                              onPageChanged: (index, reason) {}),
                        );
                      return Container();
                    },
                  ),
                  10.verticalSpace,
                  Text(
                    "Contact Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  10.verticalSpace,
                  Text(
                    "Email : ecowin@gmailcom",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  10.verticalSpace,
                  Text(
                    "Phone : 01224458595",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ]),
          ),
        ]),
      ),
    );
  }
}
