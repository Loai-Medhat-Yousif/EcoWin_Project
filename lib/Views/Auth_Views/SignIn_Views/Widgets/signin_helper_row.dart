import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Views/Auth_Views/ResetPassword_Views/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninHelperRow extends StatelessWidget {
  final bool switchvalue;
  final Function(bool?) switchonchange;
  const SigninHelperRow({
    Key? key,
    required this.switchvalue,
    required this.switchonchange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      width: double.infinity,
      child: Row(
        children: [
          Row(children: [
            Switch(
              padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
              value: switchvalue,
              onChanged: switchonchange,
              activeTrackColor: AppColors.mainColor,
              activeColor: Colors.white,
              inactiveThumbColor: AppColors.mainColor,
              inactiveTrackColor: Colors.white,
            ),
            Text("Remember Me",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontFamily: 'AirbnbCereal_W_Md')),
          ]),
          const Spacer(),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPassword(),
                  ),
                );
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: AppColors.mainColor,
                    fontFamily: 'AirbnbCereal_W_Md'),
              )),
        ],
      ),
    );
  }
}
