import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themeconstants {
  static Widget backgroundimage = Container(
    width: 4.sw,
    height: 4.sh,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/texture bg.png"),
        fit: BoxFit.cover,
      ),
    ),
  );
}
