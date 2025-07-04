import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Blogs_View_Cubit/blog_view_cubit.dart';
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Q&A_View_Cubit/questions_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Green_Guide_Views/Pages/Blogs_Views/blogs_view.dart';
import 'package:ecowin/Views/Green_Guide_Views/Pages/Questions_Views/q&aview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreenGuideView extends StatelessWidget {
  const GreenGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Themeconstants.backgroundimage,
        SafeArea(
          child: Column(children: [
            Padding(
              padding: REdgeInsets.symmetric(vertical: 10),
              child: GeneralAppBar(
                backbutton: true,
                title: "Green Guide",
                ontap: () {
                  Navigator.of(context).pop();
                },
                itemscolor: Colors.black,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => BlogsViewCubit()..fetchBlogs(),
                          child: BlogsView(),
                        ),
                      ));
                    },
                    child: Container(
                      margin: REdgeInsets.symmetric(horizontal: 0.05.sw),
                      height: 0.15.sh,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.mainColor, width: 1.w),
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 15),
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundColor: AppColors.mainColor,
                              child: Icon(
                                Icons.menu_book,
                                size: 40.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: REdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Text(
                                      "Green Guide Blogs",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: "AirbnbCereal_W_Md",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Contain Useful Blogs For You About Recycling",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "AirbnbCereal_W_Md",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  0.05.sh.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => FQAViewCubit()..fetchQuestions(),
                          child: FQAView(),
                        ),
                      ));
                    },
                    child: Container(
                      margin: REdgeInsets.symmetric(horizontal: 0.05.sw),
                      height: 0.15.sh,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.mainColor, width: 1.w),
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 15),
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundColor: AppColors.mainColor,
                              child: Icon(
                                Icons.question_mark_outlined,
                                size: 40.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: REdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Text(
                                      "Questions & Answers",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontFamily: "AirbnbCereal_W_Md",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Contain Useful Questions For You About Recycling",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "AirbnbCereal_W_Md",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
