import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.text,
    required this.tap,
    required this.hnumber,
    required this.wnumber,
    required this.color,
    required this.textColor,
  });

  final String text;
  final VoidCallback tap;
  final double hnumber;
  final double wnumber;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)).r,
        ),
      ),
      onPressed: tap,
      child: Container(
        height: hnumber,
        width: wnumber,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontFamily: 'AirbnbCereal_W_Md',
              fontSize: 20.sp,
              letterSpacing: 1,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
