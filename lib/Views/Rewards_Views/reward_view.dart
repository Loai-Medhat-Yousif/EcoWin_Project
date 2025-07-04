import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Profile_Data_Cubit/profile_data_cubit.dart';
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Rewards_View_Cubit/Coupons_View_Cubit/reward_view_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Rewards_Views/Widgets/coupons_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Themeconstants.backgroundimage,
        BlocProvider(
          create: (context) => RewardViewCubit()..fetchRewards(context),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  child: GeneralAppBar(
                    backbutton: false,
                    title: "Rewards",
                    ontap: () {},
                    itemscolor: Colors.black,
                  ),
                ),
                BlocBuilder<RewardViewCubit, RewardViewState>(
                  builder: (context, state) {
                    if (state is RewardViewError) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<RewardViewCubit>()
                                .fetchRewards(context);
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
                    if (state is RewardRedeemSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (context.mounted) {
                          ScreenDialogs.showSucessfulCouponDialog(
                            context,
                            state.discount,
                            state.couponcode,
                            () {
                              context.read<ProfileDataCubit>().refreshProfile();
                              context
                                  .read<RewardViewCubit>()
                                  .fetchRewards(context);
                            },
                          );
                        }
                      });
                    }
                    if (state is RewardRedeemError) {
                      if (context.mounted) {
                        ScreenDialogs.showFailureDialog(
                            context, state.message, 'Ok', () {
                          context.read<RewardViewCubit>().fetchRewards(context);
                        });
                      }
                    }
                    if (state is RewardViewLoading) {
                      return Expanded(
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor),
                        ),
                      );
                    } else if (state is RewardViewLoaded)
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: (state).rewards.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: REdgeInsets.all(8.0),
                                  child: CouponsCards(
                                    image: (state).rewards[index].image,
                                    discount: (state).rewards[index].discount,
                                    brandname: (state).rewards[index].brandname,
                                    price: (state).rewards[index].price,
                                    brandId: (state).rewards[index].brandId,
                                  ),
                                );
                              }),
                        ),
                      );
                    return const SizedBox();
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
