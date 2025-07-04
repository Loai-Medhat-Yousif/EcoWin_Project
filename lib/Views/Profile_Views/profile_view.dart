import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Profile_Data_Cubit/profile_data_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Views/Profile_Views/Widgets/my_profile_card.dart';
import 'package:ecowin/Views/Profile_Views/profile_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Models/Profile%20Models/profile_data_model.dart';

class ProfileView extends StatelessWidget {
  final ProfileDataModel profile;
  const ProfileView({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Padding(
          padding: REdgeInsets.symmetric(vertical: 10),
          child: GeneralAppBar(
            backbutton: false,
            title: "Profile",
            ontap: () {},
            itemscolor: Colors.black,
          ),
        ),
        Expanded(child: MyProfileCard(profile: profile)),
        20.verticalSpace,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondButtonColor,
            fixedSize: Size(0.8.sw, 50.h),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ProfileDataCubit>(),
                  child: ProfileEditView(
                    profile: profile,
                  ),
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings_outlined, color: Colors.white, size: 24.sp),
              10.horizontalSpace,
              Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: "AirbnbCereal_W_Bd",
                ),
              ),
            ],
          ),
        ),
        50.verticalSpace,
      ]),
    );
  }
}
