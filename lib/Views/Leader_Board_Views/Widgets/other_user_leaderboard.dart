import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Core/Theme/colors.dart';

class OtherUserLeaderboard extends StatelessWidget {
  final String image;
  final String name;
  final int index;
  final int points;
  const OtherUserLeaderboard({
    Key? key,
    required this.image,
    required this.name,
    required this.index,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: AppColors.backgroundColor,
        elevation: 3,
        margin: REdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 15.w),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 35.h,
                    width: 35.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.mainColor),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
            title: Text(
              overflow: TextOverflow.ellipsis,
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            trailing: Text(
              '$points',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
  }
}
