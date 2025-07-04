import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Core/Theme/colors.dart';

class GeneralTextfield extends StatelessWidget {
  const GeneralTextfield({
    Key? key,
    required this.fieldcontroller,
    required this.fieldHintText,
    required this.icon,
  }) : super(key: key);

  final TextEditingController fieldcontroller;
  final String fieldHintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(top: 20, left: 15, right: 15),
      child: TextField(
        controller: fieldcontroller,
        cursorColor: AppColors.mainColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: REdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              icon,
              color: AppColors.secondaryColor,
              size: 25.sp,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xffe2e2e2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: fieldHintText,
          hintStyle: const TextStyle(
            color: Color(0xff8e8e93),
          ),
        ),
        style: TextStyle(
          fontFamily: 'Poppins-Regular',
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
