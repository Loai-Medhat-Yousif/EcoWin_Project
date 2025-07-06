import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogDetail extends StatelessWidget {
  final String title;
  final String body;
  final String image;

  const BlogDetail(
      {super.key,
      required this.title,
      required this.body,
      required this.image});
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: REdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.mainColor),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                        0.02.sh.verticalSpace,
                        Text(
                          textAlign: TextAlign.center,
                          title,
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontFamily: "AirbnbCereal_W_Md",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        0.02.sh.verticalSpace,
                        Text(
                          body,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "AirbnbCereal_W_Md",
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
