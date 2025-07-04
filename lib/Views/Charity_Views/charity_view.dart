import 'package:ecowin/Controllers/cubit/Ui_Cubits/Charity_Images_Cubit/charity_images_cubit.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Charity_Views/Widgets/charity_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharityView extends StatelessWidget {
  const CharityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CharityImagesCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(children: [
            Themeconstants.backgroundimage,
            SafeArea(
                child: Column(children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 10),
                child: GeneralAppBar(
                  backbutton: true,
                  title: "Charity Donation",
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  itemscolor: Colors.black,
                ),
              ),
              20.verticalSpace,
              CharityViewBody(),
            ])),
          ]),
        ));
  }
}
