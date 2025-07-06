import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileCard extends StatelessWidget {
  final ProfileDataModel profile;

  MyProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.85.sw,
      padding: REdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: profile.image,
              height: 80.h,
              width: 80.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: AppColors.mainColor),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          10.verticalSpace,
          Text(
            overflow: TextOverflow.ellipsis,
            profile.name,
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: "AirbnbCereal_W_Bd",
            ),
          ),
          Text(
            profile.email,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontFamily: "AirbnbCereal_W_Lt",
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.secondButtonColor,
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
              15.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Points",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "AirbnbCereal_W_Md",
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${profile.points}",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: "AirbnbCereal_W_Blk",
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          Container(
            width: 0.85.sw,
            child: Text("Last Transaction : ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "AirbnbCereal_W_Md",
                  color: Colors.black,
                )),
          ),
          5.verticalSpace,
          profile.lastTransactiontype == null
              ? Padding(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 0.85.sw,
                    child: Text(
                      "No recent transactions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: "AirbnbCereal_W_Md",
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: REdgeInsets.symmetric(horizontal: 5),
                  child: Row(children: [
                    CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.transparent,
                        child: profile.lastTransactiontype == "debit"
                            ? Icon(
                                Icons.sync_alt,
                                color: Colors.black,
                                size: 25.sp,
                              )
                            : Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.black,
                                size: 25.sp,
                              )),
                    5.horizontalSpace,
                    Text(
                      profile.lastTransactiontype == "debit"
                          ? "Redemption Successful"
                          : "Handover Successful",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "AirbnbCereal_W_Md",
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      profile.lastTransactiontype == "debit"
                          ? "-${profile.lastTransactionAmount}"
                          : "+${profile.lastTransactionAmount}",
                      style: TextStyle(
                        color: profile.lastTransactiontype == "debit"
                            ? Colors.red
                            : AppColors.mainColor,
                        fontSize: 14.sp,
                        fontFamily: "AirbnbCereal_W_Blk",
                      ),
                    ),
                  ]),
                )
        ],
      ),
    );
  }
}
