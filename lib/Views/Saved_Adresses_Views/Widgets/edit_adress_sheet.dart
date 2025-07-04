import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Saved_Adresses_Cubit/savedadresses_cubit.dart';
import 'package:ecowin/Core/Constants/general_textfield.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showEditAddressSheet(
  BuildContext parentContext,
  int index,
  String governate,
  String city,
  String street,
  String building,
  String phone,
) {
  final SavedadressesCubit cubit = parentContext.read<SavedadressesCubit>();

  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
    ),
    context: parentContext,
    builder: (BuildContext modalContext) {
      final TextEditingController governateController =
          TextEditingController(text: governate);
      final TextEditingController cityController =
          TextEditingController(text: city);
      final TextEditingController streetController =
          TextEditingController(text: street);
      final TextEditingController buildingController =
          TextEditingController(text: building);
      final TextEditingController phoneController =
          TextEditingController(text: phone);

      return Container(
        height: MediaQuery.of(modalContext).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          children: [
            Container(
              margin: REdgeInsets.only(top: 20),
              height: 5.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.only(
                  bottom: MediaQuery.of(modalContext).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralTextfield(
                      fieldcontroller: governateController,
                      fieldHintText: "Your Governate",
                      icon: Icons.map_rounded,
                    ),
                    GeneralTextfield(
                      fieldcontroller: cityController,
                      fieldHintText: "Your City",
                      icon: Icons.location_city_outlined,
                    ),
                    GeneralTextfield(
                      fieldcontroller: streetController,
                      fieldHintText: "Your Street",
                      icon: Icons.location_on_sharp,
                    ),
                    GeneralTextfield(
                      fieldcontroller: buildingController,
                      fieldHintText: "Your Building Number",
                      icon: Icons.home_outlined,
                    ),
                    GeneralTextfield(
                      fieldcontroller: phoneController,
                      fieldHintText: "Your Phone Number",
                      icon: Icons.phone_android_outlined,
                    ),
                    10.verticalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        if (governateController.text.isEmpty) {
                          ScreenDialogs.showWarningDialog(
                            modalContext,
                            'Error',
                            'Please Enter Governate',
                            () => {},
                          );
                        } else if (cityController.text.isEmpty) {
                          ScreenDialogs.showWarningDialog(
                            modalContext,
                            'Error',
                            'Please Enter City',
                            () => {},
                          );
                        } else if (streetController.text.isEmpty) {
                          ScreenDialogs.showWarningDialog(
                            modalContext,
                            'Error',
                            'Please Enter Street',
                            () => {},
                          );
                        } else if (buildingController.text.isEmpty) {
                          ScreenDialogs.showWarningDialog(
                            modalContext,
                            'Error',
                            'Please Enter Building Number',
                            () => {},
                          );
                        } else if (phoneController.text.isEmpty) {
                          ScreenDialogs.showWarningDialog(
                            modalContext,
                            'Error',
                            'Please Enter Phone Number',
                            () => {},
                          );
                        } else {
                          cubit.editadress(
                            index,
                            governateController.text,
                            cityController.text,
                            streetController.text,
                            buildingController.text,
                            phoneController.text,
                          );
                          Navigator.pop(modalContext);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontFamily: "AirbnbCereal_W_Md",
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    15.verticalSpace
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
