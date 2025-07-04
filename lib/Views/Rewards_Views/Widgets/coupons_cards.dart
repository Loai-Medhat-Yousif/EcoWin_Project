import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Rewards_View_Cubit/Coupons_View_Cubit/reward_view_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Core/Theme/colors.dart';

class CouponsCards extends StatelessWidget {
  final int brandId;
  final String brandname;
  final String image;
  final String discount;
  final String price;

  CouponsCards({
    required this.brandId,
    required this.brandname,
    required this.image,
    required this.discount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScreenDialogs.showOutDialog(
            context, "Are you sure you want to redeem this coupon ?", "Redeem",
            () {
          context
              .read<RewardViewCubit>()
              .redeemRewards(brandId, discount, price, context);
        });
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: 0.12.sh,
              width: 0.9.sw,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor, width: 1),
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: 30.r,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Save ${discount} %",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                    color: AppColors.mainColor,
                                    fontFamily: "AirbnbCereal_W_Blk",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 0.03.sw),
                                  child: Container(
                                    height: 0.035.sh,
                                    width: 0.28.sw,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${price} Points",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "AirbnbCereal_W_Md",
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                          Text(
                            "Save ${discount} % On Any Order At $brandname",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontFamily: "AirbnbCereal_W_Md",
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
