import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralListtile extends StatelessWidget {
  const GeneralListtile({
    super.key,
    required this.listtitle,
    required this.icon,
    required this.tap,
  });

  final String listtitle;
  final IconData icon;
  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.004.sh,
      minTileHeight: 0.01.sh,
      contentPadding: REdgeInsets.only(left: 15, top: 10, bottom: 10),
      leading: Icon(icon, color: AppColors.secondaryColor, size: 20.sp),
      title: Text(listtitle,
          style: TextStyle(
            fontFamily: "AirbnbCereal_W_Md",
            fontSize: 12.sp,
          )),
      onTap: tap,
    );
  }
}
