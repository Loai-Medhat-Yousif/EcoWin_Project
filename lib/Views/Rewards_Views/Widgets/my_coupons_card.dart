import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCouponsCard extends StatelessWidget {
  final String brandimage;
  final String brandname;
  final String code;
  final String discountvalue;

  MyCouponsCard({
    super.key,
    required this.brandimage,
    required this.brandname,
    required this.code,
    required this.discountvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: brandimage,
                      height: 70.h,
                      width: 70.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.mainColor),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: REdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              code,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: AppColors.mainColor,
                                fontFamily: "AirbnbCereal_W_Blk",
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.copy, color: AppColors.mainColor),
                              iconSize: 25.sp,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: AppColors.mainColor,
                                    content: Text(
                                      'Coupon code copied to clipboard',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'AirbnbCereal_W_Md'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          "Save ${discountvalue} % On Any Order At $brandname",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black,
                            fontFamily: "AirbnbCereal_W_Md",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          15.verticalSpace
        ],
      ),
    );
  }
}
