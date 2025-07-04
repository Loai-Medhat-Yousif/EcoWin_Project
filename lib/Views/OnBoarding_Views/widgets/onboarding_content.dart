import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingContent extends StatelessWidget {
  OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Column(children: [
        Expanded(
          flex: 10,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'AirbnbCereal_W_Md',
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'AirbnbCereal_W_Lt',
                fontSize: 15.sp,
                letterSpacing: 1.2,
                height: 1.2,
              ),
            ),
          ),
        ),
        15.verticalSpace,
      ]),
    );
  }
}
