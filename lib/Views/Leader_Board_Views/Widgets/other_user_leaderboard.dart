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
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
              ],
            ),
            title: Text(
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
