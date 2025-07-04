
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget generalBottomAppBar({
  required int selectedIndex,
  required Function(int) onItemTapped,
}) {
  return BottomAppBar(
    elevation: 2,
    height: 0.07.sh,
    padding: REdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    shape: const CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(Icons.home, "Home", 0, selectedIndex, onItemTapped),
        _buildNavItem(
            Icons.redeem_outlined, "Rewards", 1, selectedIndex, onItemTapped),
        20.horizontalSpace,
        _buildNavItem(
            Icons.swap_horiz, "Exchange", 2, selectedIndex, onItemTapped),
        _buildNavItem(Icons.person, "Profile", 3, selectedIndex, onItemTapped),
      ],
    ),
  );
}

Widget _buildNavItem(IconData icon, String label, int index, int selectedIndex,
    Function(int) onTap) {
  bool isSelected = index == selectedIndex;

  return GestureDetector(
    onTap: () => onTap(index),
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color:
                  isSelected ? AppColors.mainColor : AppColors.secondaryColor,
              size: 25.sp),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? AppColors.mainColor : AppColors.secondaryColor,
              fontSize: 13.sp,
              fontFamily: "AirbnbCereal_W_Md",
            ),
          ),
        ],
      ),
    ),
  );
}
