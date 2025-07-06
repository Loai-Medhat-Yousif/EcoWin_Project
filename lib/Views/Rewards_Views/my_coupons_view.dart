import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Rewards_View_Cubit/MyCoupons_View_Cubit/my_coupons_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Rewards_Views/Widgets/my_coupons_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCouponsView extends StatelessWidget {
  const MyCouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Themeconstants.backgroundimage,
        BlocProvider(
          create: (context) => MyCouponsViewCubit()..fetchMyCoupons(context),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  child: GeneralAppBar(
                    backbutton: true,
                    title: "My Coupons",
                    ontap: () {
                      Navigator.pop(context);
                    },
                    itemscolor: Colors.black,
                  ),
                ),
                BlocBuilder<MyCouponsViewCubit, MyCouponsViewState>(
                  builder: (context, state) {
                    if (state is MyCouponsViewLoading) {
                      return Expanded(
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        )),
                      );
                    }
                    if (state is NoCouponsFound) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            "No Coupons Found",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 20.sp,
                                fontFamily: "AirbnbCereal_W_Md"),
                          ),
                        ),
                      );
                    }
                    if (state is MyCouponsViewError) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<MyCouponsViewCubit>()
                                .fetchMyCoupons(context);
                          },
                          child: Text(
                            "Try Again ?",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 15.sp,
                                fontFamily: "AirbnbCereal_W_Md"),
                          ),
                        ),
                      );
                    }
                    if (state is MyCouponsViewLoaded)
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: (state).mycoupons.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: REdgeInsets.all(8.0),
                                  child: MyCouponsCard(
                                    brandimage: state.mycoupons[index].image,
                                    brandname: state.mycoupons[index].brandname,
                                    code: state.mycoupons[index].code,
                                    discountvalue:
                                        state.mycoupons[index].discount,
                                  ),
                                );
                              }),
                        ),
                      );
                    return Container();
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
