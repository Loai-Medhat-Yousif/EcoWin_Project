import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenDialogs {
  static void showSuccessDialog(BuildContext context, String title,
      String buttonText, VoidCallback ontap) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      desc: title,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOkText: buttonText,
      titleTextStyle:
          TextStyle(fontSize: 50.sp, fontFamily: "AirbnbCereal_W_Bd"),
      btnOkOnPress: ontap,
      btnOkColor: AppColors.mainColor,
      padding: REdgeInsets.all(10),
      dialogBorderRadius: const BorderRadius.all(Radius.circular(50)).r,
    ).show();
  }

  static void showFailureDialog(BuildContext context, String title,
      String buttonText, VoidCallback ontap) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      desc: title,
      btnOkText: buttonText,
      titleTextStyle:
          TextStyle(fontSize: 50.sp, fontFamily: "AirbnbCereal_W_Bd"),
      btnOkOnPress: ontap,
      btnOkColor: AppColors.mainColor,
      padding: REdgeInsets.all(10),
      dialogBorderRadius: const BorderRadius.all(Radius.circular(50)).r,
    ).show();
  }

  static void showWarningDialog(BuildContext context, String title,
      String buttonText, VoidCallback ontap) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      desc: title,
      btnOkText: buttonText,
      titleTextStyle:
          TextStyle(fontSize: 50.sp, fontFamily: "AirbnbCereal_W_Bd"),
      btnOkOnPress: ontap,
      btnOkColor: AppColors.mainColor,
      padding: REdgeInsets.all(10),
      dialogBorderRadius: const BorderRadius.all(Radius.circular(50)).r,
    ).show();
  }

  static void showOutDialog(BuildContext context, String title,
      String buttonText, VoidCallback ontap) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      desc: title,
      dismissOnBackKeyPress: false,
      btnOkText: buttonText,
      titleTextStyle:
          TextStyle(fontSize: 50.sp, fontFamily: "AirbnbCereal_W_Bd"),
      btnOkOnPress: ontap,
      btnCancelText: "Cancel",
      btnCancelOnPress: () {},
      btnOkColor: AppColors.mainColor,
      padding: REdgeInsets.all(10),
      dialogBorderRadius: const BorderRadius.all(Radius.circular(50)).r,
    ).show();
  }

  static void showSucessfulCouponDialog(BuildContext context, String discount,
      String couponCode, VoidCallback ontap) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOkText: 'Ok',
      buttonsTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      btnOkColor: AppColors.mainColor,
      btnOkOnPress: ontap,
      body: Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16).r,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.card_giftcard, color: AppColors.mainColor, size: 48.sp),
            12.verticalSpace,
            Text(
              'Surprise gift for you',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
            8.verticalSpace,
            Text(
              discount + ' % off',
              style: TextStyle(
                fontSize: 28.sp,
                color: AppColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            8.verticalSpace,
            Text(
              'Entire Purchase',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            16.verticalSpace,
            Container(
              padding: REdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.mainColor,
                    style: BorderStyle.solid,
                    width: 1),
                borderRadius: BorderRadius.circular(8).r,
              ),
              child: Column(
                children: [
                  Text(
                    'Your coupon code : ',
                    style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        couponCode,
                        style: const TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: couponCode));
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
                        child: Row(
                          children: [
                            Icon(Icons.copy,
                                color: AppColors.mainColor, size: 20.sp),
                            4.horizontalSpace,
                            Text('Copy',
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 16.sp)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).show();
  }
}
