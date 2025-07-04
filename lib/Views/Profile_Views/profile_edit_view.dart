import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Profile_Data_Cubit/profile_data_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Constants/general_textfield.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';
import 'package:ecowin/Views/Auth_Views/ResetPassword_Views/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Edit_Profile_Cubit/edit_profile_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';

class ProfileEditView extends StatelessWidget {
  final ProfileDataModel profile;
  const ProfileEditView({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _UserNameController =
        TextEditingController(text: "${profile.name}");
    final TextEditingController _UserEmailController = TextEditingController(
      text: "${profile.email}",
    );
    final TextEditingController _UserPhoneController = TextEditingController(
      text: "${profile.phone}",
    );
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Themeconstants.backgroundimage,
            Positioned(
              child: Container(
                height: 0.2.sh,
                color: AppColors.mainColor,
              ),
            ),
            BlocListener<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  ScreenDialogs.showSuccessDialog(
                    context,
                    "Profile Updated Successfully",
                    "Ok",
                    () {
                      context.read<ProfileDataCubit>().refreshProfile();
                    },
                  );
                } else if (state is EditProfileFailure) {
                  ScreenDialogs.showFailureDialog(
                    context,
                    state.message,
                    "Ok",
                    () {},
                  );
                }
              },
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  if (state is EditProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  }

                  return SafeArea(
                    child: SingleChildScrollView(
                      padding: REdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(vertical: 10),
                            child: GeneralAppBar(
                              backbutton: true,
                              title: "Edit Profile",
                              ontap: () {
                                Navigator.of(context).pop();
                              },
                              itemscolor: Colors.white,
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Center(
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage: NetworkImage(profile.image),
                            ),
                          ),
                          0.01.sh.verticalSpace,
                          GestureDetector(
                            onTap: () async {
                              await context
                                  .read<EditProfileCubit>()
                                  .editProfilePicture();
                            },
                            child: Text(
                              "Change Profile Picture",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "AirbnbCereal_W_Md",
                              ),
                            ),
                          ),
                          GeneralTextfield(
                            fieldcontroller: _UserNameController,
                            fieldHintText: "",
                            icon: Icons.person_outline,
                          ),
                          GeneralTextfield(
                            fieldcontroller: _UserEmailController,
                            fieldHintText: "",
                            icon: Icons.email_outlined,
                          ),
                          GeneralTextfield(
                            fieldcontroller: _UserPhoneController,
                            fieldHintText: "",
                            icon: Icons.phone,
                          ),
                          0.02.sh.verticalSpace,
                          GeneralButton(
                            text: "Save",
                            tap: () {
                              context.read<EditProfileCubit>().editProfileData(
                                    _UserNameController.text,
                                    _UserEmailController.text,
                                    _UserPhoneController.text,
                                    context,
                                  );
                            },
                            color: AppColors.mainColor,
                            textColor: Colors.white,
                            hnumber: 0.05.sh,
                            wnumber: 0.5.sw,
                          ),
                          0.01.sh.verticalSpace,
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ResetPassword(),
                              ),
                            ),
                            child: Text(
                              "Change Password ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "AirbnbCereal_W_Md",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
